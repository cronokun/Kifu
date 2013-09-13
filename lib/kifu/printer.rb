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
      output << print_player_info(:white)
      output << print_player_info(:black)
      output << print_game_result
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

    def print_player_info(color)
      player, name, rank = case color
                           when :black
                             [ 'Black',
                               game.black_name,
                               game.black_rank || 'n/r' ]
                           when :white
                             [ 'White',
                               game.white_name,
                               game.white_rank || 'n/r' ]
                           end

      "#{player}: #{name} (#{rank})\n"
    end

    def print_game_result
      winner, points = game.result.split('+')
      winner = winner == 'B' ? 'Black' : 'White'
      "#{winner} wins by #{points} points\n"
    end
  end
end
