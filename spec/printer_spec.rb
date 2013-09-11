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
      game.black_name = 'Black'
      game.white_name = 'White'
      printer.print_info
    end

    it "prints header" do
      expect(output).to include "White vs Black\n--------------"
    end
  end
end
