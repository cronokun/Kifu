module Kifu
  class SgfReader
    attr_reader :file, :parser

    def initialize(file)
      @file = file
      @parser = Kifu::SgfParser.new
    end

    def parse
      parser.parse(raw_sgf_data).tap do |data|
        raise(TypeError, "can't parse file") if data.nil?
      end
    end

    private

    def raw_sgf_data
      @_raw_sgf_data ||= open(file).read
    end
  end
end
