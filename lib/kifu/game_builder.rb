module Kifu
  class GameBuilder
    attr_reader :game

    def initialize
      @game = Kifu::Game.new
    end

    def build_from_sgf(data)
    end
  end
end
