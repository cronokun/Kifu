module Kifu
  class Printer
    attr_reader :game, :output

    def initialize(game)
      @game = game
      @output = ''
    end

    def print_info
      output << print_header
    end

    private

    def print_header
      header = "#{game.white_name} vs #{game.black_name}"
      "#{header}\n#{ '-' * header.length }"
    end
  end
end
