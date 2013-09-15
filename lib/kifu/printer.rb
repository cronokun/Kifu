module Kifu
  class Printer
    attr_reader :game, :output

    def initialize(game, output = Kifu::CLI::Output.new)
      @game = game
      @output = output
    end

    def print_info
      print_header
      print_game_comment
      print_player_info(:white)
      print_player_info(:black)
      print_game_result
    end

    private

    def print_header
      header = "#{game.white_name} vs #{game.black_name}"
      output.puts header
      output.puts '-' * header.length
      output.puts
    end

    def print_game_comment
      output.puts game.comment if game.comment && !game.comment.empty?
      output.puts
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

      output.puts "#{player}: #{name} (#{rank})"
    end

    def print_game_result
      winner, points = game.result.split('+')
      winner = winner == 'B' ? 'Black' : 'White'
      output.puts "#{winner} wins by #{points} points"
    end
  end
end
