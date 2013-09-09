require 'spec_helper'

describe Kifu::SgfReader do
  let(:file) { 'spec/fixtures/show_simple_info.sgf' }
  let(:reader) { Kifu::SgfReader.new(file) }

  describe "#initialize" do
    it "assigns file" do
      reader = Kifu::SgfReader.new('path/to/file.sgf')
      expect(reader.file).to eq 'path/to/file.sgf'
    end
  end

  describe "#parse" do
    it "parses file" do
      Kifu::SgfParser.any_instance.should_receive(:parse)
      reader.parse
    end

    context "bad file path" do
      it "raises an error" do
        reader = Kifu::SgfReader.new('bad_file_path')
        expect {
          reader.parse
        }.to raise_error Errno::ENOENT
      end
    end
  end
end
