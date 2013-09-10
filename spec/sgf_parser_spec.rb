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

    context "multi-line" do
      it "parses nodes separated by new line" do
        expect(
          parse "(;B[dd]\n;W[kk])"
        ).not_to be_nil
      end

      it "parses node with properties separated by new line" do
        expect(
          parse "(;PB[Honinbo Dosaku]\nPW[Yasui Chitetsu])"
        ).not_to be_nil
      end

      it "parses multi-line file" do
        sgf =
%q{(;AP[MultiGo:3.9.4]SZ[19]GC[Hikaru no Go chap 001, manga only]DT[1669-11-07]
PC[Residence of Lord Matsudaira of Hyogo]PB[Honinbo Dosaku]PW[Yasui Chitetsu]RE[W+4]
US[JBvR]SO[GoGoD]CP[My Friday Night Files]
;B[qd];W[oc];B[cp];W[eq];B[dc];W[ce];B[ch];W[op];B[jq];W[lq];B[gq];W[do];B[co];W[dn]
;B[cm];W[dm];B[cl];W[hc];B[ed];W[cn];B[bn];W[bm];B[bl];W[bo];B[am];W[cq];B[bp];W[bc]
;B[df];W[kd];B[qp];W[qq];B[rq];W[pq];B[ro];W[qh];B[od];W[nd];B[pc];W[oe];B[pd];W[nc]
;B[qk];W[qf];B[pf];W[pe];B[qe];W[rf];B[ne];W[of];B[me];W[pg];B[lc];W[md];B[ld];W[le]
;B[ke];W[lf];B[jd];W[kf];B[kc];W[ie];B[hd];W[rc];B[pb];W[ob];B[rb];W[qm];B[rm];W[rd]
;B[oa];W[na];B[qa];W[pa];B[dp];W[ep];B[fo];W[oa];B[dq];W[dr];B[bq];W[eo];B[fn];W[gp]
;B[fp];W[fq];B[hq];W[fm];B[gm];W[fl];B[gl];W[gk];B[hn];W[fj];B[ek];W[fk];B[id];W[qn]
;B[rn];W[cb];B[ik];W[ij];B[jj];W[ii];B[mp];W[mq];B[np];W[nq];B[oo];W[pp];B[po];W[qo]
;B[rp];W[no];B[nn];W[mo];B[pm];W[ko];B[jn];W[hk];B[jk];W[hl];B[jo];W[hm];B[gn];W[jm]
;B[mn];W[lp];B[km];W[jl];B[kl];W[kk];B[ji];W[lk];B[jh];W[jf];B[ih];W[hh];B[hg];W[gh]
;B[if];W[hf];B[ig];W[gg];B[mi];W[kn];B[ml];W[fr];B[kr];W[mk];B[mg];W[mf];B[ng];W[nf]
;B[db];W[nl];B[om];W[lm])}

        expect(parse(sgf)).not_to be_nil
      end
    end
  end

  private

  def parse(data, options = {})
    parser.parse(data, options)
  end
end
