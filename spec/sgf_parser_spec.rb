require 'spec_helper'

describe Kifu::SgfParser do
  let(:parser) { Kifu::SgfParser.new }

  describe "#parse" do
    context "property value" do
      it "parses all text inside '[' and ']'" do
        expect(
          parse '[This is simple text value]', root: :prop_value
        ).not_to be_nil
      end

      it "parses text with '[' in it" do
        expect(
          parse '[foo >:[ bar]', root: :prop_value
        ).not_to be_nil
      end

      it "parses text with escaped ] in it" do
        expect(
          parse '[jansteen 4d: Can anyone explain [me\] k4?]', root: :prop_value
        ).not_to be_nil
      end

      it "returns text between '[' and ']'" do
        result = parse('[foobar]', root: :prop_value)
        expect(result.value).to eq 'foobar'
      end
    end

    context "property" do
      let(:result) { parse 'PB[Honinbo Dosaku]', root: :property }

      it "parses property" do
        expect(result).not_to be_nil
      end

      it "returns property name" do
        expect(result.name).to eq 'PB'
      end

      it "returns single property value" do
        expect(result.value).to eq 'Honinbo Dosaku'
      end
    end

    context "property (multi-value)" do
      let(:result) { parse('B[qd][cp][dc]', root: :property) }

      it "parses multi-value properties" do
        expect(result).not_to be_nil
      end

      it "returns array of property values" do
        expect(result.value).to match_array ['qd', 'cp', 'dc']
      end

    end

    context "node" do
      let(:result) { parse(';W[oc]', root: :node) }

      it "parses node" do
        expect(result).not_to be_nil
      end

      it "returns node name" do
        expect(result.name).to eq 'W'
      end

      it "returns node value" do
        expect(result.value).to eq 'oc'
      end

      it "#multiple? returns false" do
        expect(result.multiple?).to be_false
      end
    end

    context "node (multi-property)" do
      let(:result) { parse(';SZ[19]PB[Honinbo Dosaku]PW[Yasui Chitetsu]RE[W+4]', root: :node) }

      it "parses node with multiple properties" do
        expect(result).not_to be_nil
      end

      it "#multiple? returns true" do
        expect(result.multiple?).to be_true
      end

      it "returns list of properties" do
        expect(result.properties.size).to eq 4
      end

      it "returns hash of properties" do
        result_hash = {
          'SZ' => '19',
          'PB' => 'Honinbo Dosaku',
          'PW' => 'Yasui Chitetsu',
          'RE' => 'W+4' }
        expect(result.hash).to eq result_hash
      end
    end

    context "sequence" do
      let(:result) { parse(';B[qd];W[oc];B[cp];W[eq]', root: :sequence) }

      it "parses sequence of nodes" do
        expect(result).not_to be_nil
      end

      it "returns list of nodes" do
        expect(result.nodes.size).to eq 4
      end
    end

    context "game tree" do
      let(:result) {
        parse '(;SZ[19]GC[Hikaru no Go chap 001, manga only]DT[1669-11-07];B[db];W[nl];B[om];W[lm])'
      }

      it "parses game tree" do
        expect(result).not_to be_nil
      end

      it "returns list of nodes" do
        expect(result.nodes.size).to eq 5
      end

      it "returns hash of all nodes" do
        expect(result.hashes).to eq [
          {'SZ' => '19',
           'GC' => 'Hikaru no Go chap 001, manga only',
           'DT' => '1669-11-07'},
          {'B' => 'db'},
          {'W' => 'nl'},
          {'B' => 'om'},
          {'W' => 'lm'}
        ]
      end
    end
  end

  private

  def parse(data, options = {})
    parser.parse(data, options)
  end
end
