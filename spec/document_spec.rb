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

      @semSAFAvgPTco  = Semantics.new(@@agg_avg, @@g_simple, @@h1_proba_tconorm, @@h2_proba_tconorm)
      @semBHAvgPTco   = Semantics.new(@@agg_avg, @@g_cat, @@h1_cat, @@h2_proba_tconorm)
      @semSAFProdPTco  = Semantics.new(@@agg_prod, @@g_simple, @@h1_proba_tconorm, @@h2_proba_tconorm)
      @semBHProdPTco   = Semantics.new(@@agg_prod, @@g_cat, @@h1_cat, @@h2_proba_tconorm)
    end

    context "when using case 1" do
      context "when Example 2" do
        context "when 0.1 0.9 example" do
          it "computes S properly" do
            exp = 0.35
            s   = @semSAFAvg.computeS(@a, @b)
            s2  = @semSAFAvg.computeS(@a, @b)
            s3  = @semBHAvg.computeS(@a, @b)
            s4  = @semBHAvg.computeS(@a, @b)
            expect(s).to be_within(0.01).of(exp)
            expect(s2).to be_within(0.01).of(exp)
            expect(s3).to be_within(0.01).of(exp)
            expect(s4).to be_within(0.01).of(exp)
          end

          context "when using SAF" do
            it "computes V properly" do
              exp = 0.42
              v = @semSAFAvg.computeV(@a)
              expect(v).to be_within(0.01).of(exp)
            end
          end

          context "when using BH" do
            it "computes V properly" do
              exp = 0.59
              v = @semBHAvg.computeV(@a)
              expect(v).to be_within(0.01).of(exp)
            end
          end
        end # context 0.1 0.9

        context "when 0.5 0.5 example" do
          it "computes S properly" do
            exp = 0.35
            s   = @semSAFAvg.computeS(@a2, @b2)
            s2  = @semSAFAvg.computeS(@a2, @b2)
            s3  = @semBHAvg.computeS(@a2, @b2)
            s4  = @semBHAvg.computeS(@a2, @b2)
            expect(s).to be_within(0.01).of(exp)
            expect(s2).to be_within(0.01).of(exp)
            expect(s3).to be_within(0.01).of(exp)
            expect(s4).to be_within(0.01).of(exp)
          end

          context "when using SAF" do
            it "computes V properly" do
              exp = 0.42
              v = @semSAFAvg.computeV(@a2)
              expect(v).to be_within(0.01).of(exp)
            end
          end

          context "when using BH" do
            it "computes V properly" do
              exp = 0.59
              v = @semBHAvg.computeV(@a2)
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

          it "computes V properly" do
            expSAF = 0.022
            expBH  = 0.318

            sSAF = @semSAFAvg.computeV(@d3)
            sBH  = @semBHAvg.computeV(@d3)

            expect(sSAF).to be_within(0.01).of(expSAF)
            expect(sBH).to be_within(0.01).of(expBH)
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

          it "computes V properly" do
            expSAF = 0.116
            expBH  = 0.396

            sSAF = @semSAFProd.computeV(@d3)
            sBH  = @semBHProd.computeV(@d3)

            expect(sSAF).to be_within(0.01).of(expSAF)
            expect(sBH).to be_within(0.01).of(expBH)
          end
        end # context product
      end # context Example 3
    end # context case 1

    context "when using case 2" do
      context "when Example 2" do
        context "when 0.1 0.9 example" do
          it "computes S properly" do
            exp = 0.637
            s   = @semSAFAvgPTco.computeS(@a, @b)
            s2  = @semBHAvgPTco.computeS(@a, @b)
            expect(s).to be_within(0.01).of(exp)
            expect(s2).to be_within(0.01).of(exp)
          end

          context "when using SAF" do
            it "computes V properly" do
              exp = 0.13
              v = @semSAFAvgPTco.computeV(@a)
              expect(v).to be_within(0.01).of(exp)
            end
          end

          context "when using BH" do
            it "computes V properly" do
              exp = 0.44
              v = @semBHAvgPTco.computeV(@a)
              expect(v).to be_within(0.01).of(exp)
            end
          end
        end # context 0.1 0.9

        context "when 0.5 0.5 example" do
          it "computes S properly" do
            exp = 0.525
            s   = @semSAFAvgPTco.computeS(@a2, @b2)
            s2  = @semBHAvgPTco.computeS(@a2, @b2)
            expect(s).to be_within(0.01).of(exp)
            expect(s2).to be_within(0.01).of(exp)
          end

          context "when using SAF" do
            it "computes V properly" do
              exp = 0.23
              v = @semSAFAvgPTco.computeV(@a2)
              expect(v).to be_within(0.01).of(exp)
            end
          end

          context "when using BH" do
            it "computes V properly" do
              exp = 0.488
              v = @semBHAvgPTco.computeV(@a2)
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

            sA   = @semSAFAvgPTco.computeS(@d3, @a3)
            sB   = @semSAFAvgPTco.computeS(@d3, @b3)
            sC   = @semSAFAvgPTco.computeS(@d3, @c3)

            sA2  = @semBHAvgPTco.computeS(@d3, @a3)
            sB2  = @semBHAvgPTco.computeS(@d3, @b3)
            sC2  = @semBHAvgPTco.computeS(@d3, @c3)

            expect(sA).to  be_within(0.01).of(expA)
            expect(sA2).to be_within(0.01).of(expA)
            expect(sB).to  be_within(0.01).of(expB)
            expect(sB2).to be_within(0.01).of(expB)
            expect(sC).to  be_within(0.01).of(expC)
            expect(sC2).to be_within(0.01).of(expC)
          end

          it "computes V properly" do
            expSAF = 0.022
            expBH  = 0.318

            sSAF = @semSAFAvgPTco.computeV(@d3)
            sBH  = @semBHAvgPTco.computeV(@d3)

            expect(sSAF).to be_within(0.01).of(expSAF)
            expect(sBH).to be_within(0.01).of(expBH)
          end
        end # context avg

        context "when using Product aggregator" do
          it "computes S properly" do
            expA = 0.479
            expB = 0.448
            expC = 0.598

            sA   = @semSAFProdPTco.computeS(@d3, @a3)
            sB   = @semSAFProdPTco.computeS(@d3, @b3)
            sC   = @semSAFProdPTco.computeS(@d3, @c3)

            sA2  = @semBHProdPTco.computeS(@d3, @a3)
            sB2  = @semBHProdPTco.computeS(@d3, @b3)
            sC2  = @semBHProdPTco.computeS(@d3, @c3)

            expect(sA).to  be_within(0.01).of(expA)
            expect(sA2).to be_within(0.01).of(expA)
            expect(sB).to  be_within(0.01).of(expB)
            expect(sB2).to be_within(0.01).of(expB)
            expect(sC).to  be_within(0.01).of(expC)
            expect(sC2).to be_within(0.01).of(expC)
          end

          it "computes V properly" do
            expSAF = 0.116
            expBH  = 0.396

            sSAF = @semSAFProdPTco.computeV(@d3)
            sBH  = @semBHProdPTco.computeV(@d3)

            expect(sSAF).to be_within(0.01).of(expSAF)
            expect(sBH).to be_within(0.01).of(expBH)
          end
        end # context product
      end # context Example 3
    end # context case 2
  end # describe
end # module
