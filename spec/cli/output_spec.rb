require 'spec_helper'

describe Kifu::CLI::Output do
  let(:output) { Kifu::CLI::Output.new }

  describe "#intialize" do
    it "creates new output buffer" do
      expect(output.lines).to eq []
    end
  end

  describe "#puts" do
    it "adds line to the output" do
      output.puts 'All your base are belong to us!'
      expect(output.lines).to include 'All your base are belong to us!'
    end

    it "adds empty line when argument is omitted" do
      output.puts
      expect(output.lines).to include nil
    end
  end

  describe "#output" do
    it "returns all lines" do
      output.puts 'First'
      output.puts
      output.puts 'Second'
      expect(output.output).to eq "First\n\nSecond"
    end
  end
end
