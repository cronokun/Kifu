require 'spec_helper'

describe Kifu::Printer do
  let(:game) { Kifu::Game.new }
  let(:printer) { Kifu::Printer.new(game) }

  describe "#initialize" do
    it "stores game" do
      expect(printer.game).to eq game
    end
  end

  describe "#print_info" do

  end
end
