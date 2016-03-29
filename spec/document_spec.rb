module Gradualsem
  describe Semantics do
    before(:all) do
      @a = Node.new("a")
      @b = Node.new("b", 0.1)
      @c = Node.new("c", 0.9)
      @a2 = Node.new("a'")
      @b2 = Node.new("b'", 0.5)
      @c2 = Node.new("c'", 0.5)

      @a.add_attackers(@b, @c)
      @b.add_similar(@c, 0.6)
      @a2.add_attackers(@b2, @c2)
      @b2.add_similar(@c2, 0.6)

      @semSAF = Semantics.new(@@agg_prod, @@g_simple, @@h1_proba_tconorm, @@h2_avg)
      @semBH  = Semantics.new(@@agg_prod, @@g_cat, @@h1_cat, @@h2_avg)

      @a3 = Node.new("a", 0.999)
      @b3 = Node.new("b", 0.999)
      @c3 = Node.new("c", 0.999)
      @d3 = Node.new("d")

      @d3.add_attackers(@a3, @b3, @c3)
      @a3.add_similar(@b3, 0.8)
      @a3.add_similar(@c3, 0.4)
      @b3.add_similar(@c3, 0.5)

      @semSAFAvg  = Semantics.new(@@agg_avg, @@g_simple, @@h1_proba_tconorm, @@h2_avg)
      @semSAFProd = Semantics.new(@@agg_prod, @@g_simple, @@h1_proba_tconorm, @@h2_avg)
      @semBHAvg   = Semantics.new(@@agg_avg, @@g_cat, @@h1_cat, @@h2_avg)
      @semBHProd  = Semantics.new(@@agg_prod, @@g_cat, @@h1_cat, @@h2_avg)
    end

    context "when using case 1" do
      context "when Example 2" do
        context "when 0.1 0.9 example" do
          it "computes S properly" do
            exp = 0.35
            s   = @semSAF.computeS(@a, @b)
            s2  = @semSAF.computeS(@a, @b)
            s3  = @semBH.computeS(@a, @b)
            s4  = @semBH.computeS(@a, @b)
            expect(s).to eq(exp)
            expect(s2).to eq(exp)
            expect(s3).to eq(exp)
            expect(s4).to eq(exp)
          end

          context "when using SAF" do
            it "computes V properly" do
              exp = 0.42
              v = @semSAF.computeV(@a)
              expect(v).to be_within(0.01).of(exp)
            end
          end

          context "when using BH" do
            it "computes V properly" do
              exp = 0.59
              v = @semBH.computeV(@a)
              expect(v).to be_within(0.01).of(exp)
            end
          end
        end # context 0.1 0.9

        context "when 0.5 0.5 example" do
          it "computes S properly" do
            exp = 0.35
            s   = @semSAF.computeS(@a2, @b2)
            s2  = @semSAF.computeS(@a2, @b2)
            s3  = @semBH.computeS(@a2, @b2)
            s4  = @semBH.computeS(@a2, @b2)
            expect(s).to eq(exp)
            expect(s2).to eq(exp)
            expect(s3).to eq(exp)
            expect(s4).to eq(exp)
          end

          context "when using SAF" do
            it "computes V properly" do
              exp = 0.42
              v = @semSAF.computeV(@a2)
              expect(v).to be_within(0.01).of(exp)
            end
          end

          context "when using BH" do
            it "computes V properly" do
              exp = 0.59
              v = @semBH.computeV(@a2)
              expect(v).to be_within(0.01).of(exp)
            end
          end
        end # context 0.5 0.5
      end # context Example 2

      context "when Example 3" do
        context "when using Avg aggregator" do
          it "computes S properly" do
            expA = 0.699
            expB = 0.674
            expC = 0.774

            sA   = @semSAFAvg.computeS(@d3, @a3)
            sB   = @semSAFAvg.computeS(@d3, @b3)
            sC   = @semSAFAvg.computeS(@d3, @c3)

            sA2  = @semBHAvg.computeS(@d3, @a3)
            sB2  = @semBHAvg.computeS(@d3, @b3)
            sC2  = @semBHAvg.computeS(@d3, @c3)

            expect(sA).to  be_within(0.01).of(expA)
            expect(sA2).to be_within(0.01).of(expA)
            expect(sB).to  be_within(0.01).of(expB)
            expect(sB2).to be_within(0.01).of(expB)
            expect(sC).to  be_within(0.01).of(expC)
            expect(sC2).to be_within(0.01).of(expC)
          end
        end # context avg

        context "when using Product aggregator" do
          it "computes S properly" do
            expA = 0.479
            expB = 0.448
            expC = 0.598

            sA   = @semSAFProd.computeS(@d3, @a3)
            sB   = @semSAFProd.computeS(@d3, @b3)
            sC   = @semSAFProd.computeS(@d3, @c3)

            sA2  = @semBHProd.computeS(@d3, @a3)
            sB2  = @semBHProd.computeS(@d3, @b3)
            sC2  = @semBHProd.computeS(@d3, @c3)

            expect(sA).to  be_within(0.01).of(expA)
            expect(sA2).to be_within(0.01).of(expA)
            expect(sB).to  be_within(0.01).of(expB)
            expect(sB2).to be_within(0.01).of(expB)
            expect(sC).to  be_within(0.01).of(expC)
            expect(sC2).to be_within(0.01).of(expC)
          end
        end # context product
      end # context Example 3
    end # context case 1
  end # describe
end # module
