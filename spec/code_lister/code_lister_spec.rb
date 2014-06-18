require_relative "../spec_helper"
describe CodeLister do
  let(:file_list) do
    CodeLister.files(base_dir: "spec/fixtures", exts: %w[xxx.rb], recursive: true)
  end

  context "#files_from_command" do
    it "returns empty result with invalid parameter" do
      expect(CodeLister.files_from_command("invalid-command", nil)).to eq []
    end

    describe "use with `find` command" do
      it "returns non-empty list when base_dir is not specified (implicitly set)" do
        expect(CodeLister.files_from_command("find ./spec/fixtures -type f -iname '*.rb'").sort)
          .to eq [
            "./spec/fixtures/demo1.xxx.rb",
            "./spec/fixtures/demo1.yyy.rb",
            "./spec/fixtures/demo2.xxx.rb",
            "./spec/fixtures/demo2.yyy.rb"
          ]
      end
      it "returns non-empty list when base_dir is current directory" do
        base_dir = "."
        expect(CodeLister.files_from_command("find ./spec/fixtures -type f -iname '*.rb'", base_dir).sort)
          .to eq [
            "./spec/fixtures/demo1.xxx.rb",
            "./spec/fixtures/demo1.yyy.rb",
            "./spec/fixtures/demo2.xxx.rb",
            "./spec/fixtures/demo2.yyy.rb"
          ]
      end
      it "returns result list when base_dir is a not a current directory" do
        base_dir = File.expand_path(File.dirname(__FILE__) + "/../fixtures")
        expect(CodeLister.files_from_command("find ./spec/fixtures -type f -iname '*.rb'", base_dir).sort)
          .to eq [
            "./demo1.xxx.rb",
            "./demo1.yyy.rb",
            "./demo2.xxx.rb",
            "./demo2.yyy.rb"
          ]
      end
      it "returns empty list when no match found" do
        base_dir = File.expand_path(File.dirname(__FILE__) + "/../fixtures")
        expect(CodeLister.files_from_command("find ./spec/fixtures -type f -iname '*.XYZ'", base_dir).sort)
          .to be_empty
      end
    end

    # TODO: Setup the fixtures to make this test possible (e.g. use `fakefs`?)
    # describe "use with `git diff --name-only` command" do
    #   it "returns result when git returns valid result" do
    #     # Note: base_dir must be "." only for `git diff --name-only` to work
    #     base_dir = "."
    #     expect(CodeLister.files_from_command("git diff --name-only HEAD~4", base_dir).sort)
    #       .to eq [
    #         "./lib/code_lister/code_lister.rb",
    #         "./spec/code_lister/code_lister_spec.rb"
    #       ]
    #   end
    # end
  end

  context "#files" do
    it "works with invalid input" do
      expect { CodeLister.files("bad-args") }.to raise_error
    end

    it "works with valid input" do
      expect(CodeLister.files(base_dir: "spec/fixtures", exts: %w[xxx.rb])).to eq ["./demo1.xxx.rb",
                                                                                   "./demo2.xxx.rb"]
    end

    it "returns empty result if no match found" do
      expect(CodeLister.files(base_dir: "spec/fixtures", exts: %w[invalid-extension])).to eq []
    end
  end

  context "#filter" do
    it "works with empty filter inputs" do
      expect(CodeLister.filter(file_list, inc_words: [], exc_words: [])).to eq file_list
    end

    it "works with unique match" do
      expect(CodeLister.filter(file_list, inc_words: %w[demo1])).to eq ["./demo1.xxx.rb"]
    end

    it "works with multiples matches" do
      expect(CodeLister.filter(file_list, inc_words: %w[demo])).to eq ["./demo1.xxx.rb",
                                                                       "./demo2.xxx.rb"]
      expect(CodeLister.filter(file_list, inc_words: %w[xxx])).to eq ["./demo1.xxx.rb",
                                                                      "./demo2.xxx.rb"]
    end

    it "filters out the words that we don't want" do
      expect(CodeLister.filter(file_list, exc_words: %w[demo1])).to eq ["./demo2.xxx.rb"]
      expect(CodeLister.filter(file_list, exc_words: %w[xxx])).to eq []
    end

    context "with ignore_case" do
      it "ignores case by default" do
        expect(CodeLister.filter(file_list, exc_words: %w[DeMo1])).to eq CodeLister.filter(file_list, exc_words: %w[demo1])
        expect(CodeLister.filter(file_list, exc_words: %w[DeMo1])).to eq ["./demo2.xxx.rb"]
      end
      it "does not ignore case if specified" do
        expect(CodeLister.filter(file_list, exc_words: %w[DeMo1], ignore_case: false)).to eq ["./demo1.xxx.rb",
                                                                                              "./demo2.xxx.rb"]
      end
    end
  end
end
