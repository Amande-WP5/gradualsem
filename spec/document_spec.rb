module Gradualsem
  describe Semantics do
    before(:all) do
      @a = Node.new
      @b = Node.new(0.1)
      @c = Node.new(0.9)
      @a2 = Node.new
      @b2 = Node.new(0.5)
      @c2 = Node.new(0.5)

      @a.add_attackers(@b, @c)
      @b.add_similar(@c, 0.6)

      @a2.add_attackers(@b2, @c2)
      @b2.add_similar(@c2, 0.6)

      @semSAF = Semantics.new(@@agg_sum, @@g_simple, @@h1_proba_tconorm, @@h2_avg)
      @semBH  = Semantics.new(@@agg_sum, @@g_cat, @@h1_cat, @@h2_avg)
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
        end

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
        end
      end
    end
  end
end
