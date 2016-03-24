module Gradualsem
  def g_simple(val)
    g_cat(val) * (1 - val)
  end

  def h1_proba_tconorm(acc, val)
    acc + val - acc * val
  end

  def h1_einstein(acc, val)
    (acc + val) / (1.0 + acc * val)
  end

  def h1_cat(acc, val)
    acc += val
  end

  def g_cat(val)
    1.0 / (1.0 + val)
  end

  class Semantics
    attr_reader :agg, :g, :h1, :h2

    def initialize(agg, g, h1, h2)
      @agg   = agg
      @g     = g
      @h1    = h1
      @h2    = h2
    end

    def computeS(arg1, arg2)
      intersection = arg1.attackers & arg2.similar.keys
      if intersection.empty?
        arg2.value
      else
        intersection.map do |node|
          @h2(arg2.value, node.value) * (2 - arg2.similar[node]) / 2
        end.reduce(:agg)
      end
    end

    def computeV(arg1)
      @g(arg1.attackers.map {|node| computeS(arg1, node)}.reduce(:h1))
    end
  end
end
