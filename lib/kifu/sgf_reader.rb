module Kifu
  class SgfReader
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def parse
      Kifu::SgfParser.new.parse(raw_sgf_data)
    end

    private

    def raw_sgf_data
      @_raw_sgf_data ||= open(file).read
    end
  end
end
