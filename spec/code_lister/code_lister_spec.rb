require_relative '../spec_helper'
describe CodeLister do

  let(:file_list) {
    CodeLister.files(base_dir: 'spec/fixtures', exts: %w(xxx.rb), recursive: true)
  }

  context "#files" do
    it 'works with invalid input' do
      expect{ CodeLister.files('bad-args')}.to raise_error
    end

    it 'works with valid input' do
      expect(CodeLister.files(base_dir: 'spec/fixtures', exts: %w(xxx.rb))).to eq ['spec/fixtures/demo1.xxx.rb',
                                                                                   'spec/fixtures/demo2.xxx.rb']
    end

    it 'returns empty result if no match found' do
      expect(CodeLister.files(base_dir: 'spec/fixtures', exts: %w(invalid-extension))).to eq []
    end
  end

  context "#filter" do
    it "works with empty filter inputs" do
      expect(CodeLister.filter(file_list, inc_words: [], exc_words: [])).to eq file_list
    end

    it "works with unique match" do
      expect(CodeLister.filter(file_list, inc_words: %w(demo1))).to eq ["spec/fixtures/demo1.xxx.rb"]
    end

    it "works with multiples matches" do
      expect(CodeLister.filter(file_list, inc_words: %w(demo))).to eq ["spec/fixtures/demo1.xxx.rb",
                                                                       "spec/fixtures/demo2.xxx.rb"]

      expect(CodeLister.filter(file_list, inc_words: %w(xxx))).to eq ["spec/fixtures/demo1.xxx.rb",
                                                                      "spec/fixtures/demo2.xxx.rb"]
    end

    it "filters out the words that we don't want" do
      expect(CodeLister.filter(file_list, exc_words: %w(demo1))).to eq ["spec/fixtures/demo2.xxx.rb"]
      expect(CodeLister.filter(file_list, exc_words: %w(xxx))).to eq []
    end

    context 'with ignore_case' do
      it 'ignores case by default' do
        expect(CodeLister.filter(file_list, exc_words: %w(DeMo1))).to eq CodeLister.filter(file_list, exc_words: %w(demo1))
        expect(CodeLister.filter(file_list, exc_words: %w(DeMo1))).to eq ["spec/fixtures/demo2.xxx.rb"]
      end
      it 'does not ignore case if specified' do
        expect(CodeLister.filter(file_list, exc_words: %w(DeMo1), ignore_case: false)).to eq ["spec/fixtures/demo1.xxx.rb",
                                                                                              "spec/fixtures/demo2.xxx.rb" ]
      end
    end
  end
end
