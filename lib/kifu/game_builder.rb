module Kifu
  class GameBuilder
    attr_reader :game

    def initialize
      @game = Kifu::Game.new
    end

    def build_from_sgf(data)
      # first node containds all game info
      data.hashes.first.tap do |info|
        game.black_name = info['PB']
        game.black_rank = info['BR']
        game.white_name = info['PW']
        game.white_rank = info['WR']
        game.comment = info['GC']
        game.result  = info['RE']
      end

      # return populated game
      game
    end
  end
end
