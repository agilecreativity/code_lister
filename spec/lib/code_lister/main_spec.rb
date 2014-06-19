require_relative "../../spec_helper"
describe CodeLister do
  context "#files" do
    it "works with non_exts option" do
      list = CodeLister::Main.run base_dir: "spec/fixtures/",
                                  recursive: true,
                                  non_exts: %w[noexts1_zzz noexts2_zzz]
      expect(list).to eq ["./noexts1_zzz",
                          "./noexts2_zzz"]
    end
  end
end
