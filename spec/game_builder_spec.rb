require 'spec_helper'

describe Kifu::GameBuilder do
  let(:builder) { Kifu::GameBuilder.new }
  let(:data) { double(hashes: test_data_hash) }

  describe "#initialize" do
    it "creates new game" do
      expect(builder.game).to be_a Kifu::Game
    end
  end

  describe "#build_from_sgf" do
    context "game info" do
      before do
        builder.build_from_sgf(data)
      end

      it "sets players name and rank" do
        expect(builder.game.black_name).to eq 'Honinbo Shusaku'
        expect(builder.game.white_name).to eq 'Honinbo Shuwa'
        expect(builder.game.black_rank).to eq '6d'
        expect(builder.game.white_rank).to eq '8d'
      end

      it "sets game comment" do
        expect(builder.game.comment).to eq 'game from Hikaru no Go chapter 2, this version only in the anime'
      end

      it "sets game result" do
        expect(builder.game.result).to eq 'W+4'
      end
    end

    it "returns game" do
      expect(
        builder.build_from_sgf(data)
      ).to eq builder.game
    end
  end

  # Test data:
  # (;PB[Honinbo Shusaku]BR[6d]PW[Honinbo Shuwa]WR[8d])
  def test_data_hash
    [{
      'PB' => 'Honinbo Shusaku',
      'BR' => '6d',
      'PW' => 'Honinbo Shuwa',
      'WR' => '8d',
      'GC' => 'game from Hikaru no Go chapter 2, this version only in the anime',
      'RE' => 'W+4'
    }]
  end
end
