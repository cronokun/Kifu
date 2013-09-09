require 'spec_helper'

describe Kifu::GameBuilder do
  let(:builder) { Kifu::GameBuilder.new }
  describe "#initialize" do
    it "creates new game" do
      expect(builder.game).to be_a Kifu::Game
    end
  end

  describe "#build_from_sgf" do
  end
end
