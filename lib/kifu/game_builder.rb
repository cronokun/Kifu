module Kifu
  class GameBuilder
    attr_reader :game

    def initialize
      @game = Kifu::Game.new
    end

    def build_from_sgf(data)
      info = data.hashes.first # first node containds all game info
      game.black_name = info['PB']
      game.black_rank = info['BR']
      game.white_name = info['PW']
      game.white_rank = info['WR']
    end
  end
end
