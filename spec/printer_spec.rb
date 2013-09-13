require 'spec_helper'

describe Kifu::Printer do
  let(:game) { Kifu::Game.new }
  let(:printer) { Kifu::Printer.new(game) }

  describe "#initialize" do
    it "stores game" do
      expect(printer.game).to eq game
    end

    it "creates new output" do
      expect(printer.output).to eq ''
    end
  end

  describe "#print_info" do
    let(:output) { printer.output }

    before do
      game.black_name = 'Otake Hideo'
      game.black_rank = nil
      game.white_name = 'Takemiya Masaki'
      game.white_rank = '9d'
      game.comment = 'This is a test game'
      printer.print_info
    end

    it "prints header" do
      expect(output).to include "Takemiya Masaki vs Otake Hideo\n------------------------------"
    end

    it "prints game comment" do
      expect(output).to include 'This is a test game'
    end

    it "prints white player's name and rank" do
      expect(output).to include 'White: Takemiya Masaki (9d)'
    end

    it "prints black player's name and rank" do
      expect(output).to include 'Black: Otake Hideo (n/r)'
    end
  end
end
