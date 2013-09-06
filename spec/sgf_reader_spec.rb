require 'spec_helper'

describe Kifu::SgfReader do
  context 'new instanse' do
    it 'assigns file to @file' do
      file = double('file')
      reader = Kifu::SgfReader.new(file)
      expect(reader.file).to eq file
    end
  end
end
