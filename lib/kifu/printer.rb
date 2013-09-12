module Kifu
  class Printer
    attr_reader :game, :output

    def initialize(game)
      @game = game
      @output = ''
    end

    def print_info
      output << print_header
      output << print_game_comment
    end

    private

    def print_header
      header = "#{game.white_name} vs #{game.black_name}"
      "#{header}\n#{ '-' * header.length }\n"
    end

    def print_game_comment
      if game.comment && !game.comment.empty?
        "\n#{game.comment}\n\n"
      else
        "\n\n"
      end
    end
  end
end
