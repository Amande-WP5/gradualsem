module Gradualsem
  EPSILON = 0.001
  # List of functions to be used in the semantics

  # g functions, lambda on one value
  @@g_simple = -> (val) do
    1.0 / (1.0 + EPSILON) * (1 - val)
  end

  @@g_cat = -> (val) do
    1.0 / (1.0 + val)
  end

  # h1 functions, lambda on accumulator and value for incremental building
  @@h1_proba_tconorm = -> (acc, val) do
    acc + val - acc * val
  end

  @@h1_einstein = -> (acc, val) do
    (acc + val) / (1.0 + acc * val)
  end

  @@h1_cat = -> (acc, val) do
    acc + val
  end

  # agg functions, lambda on array of values (because of mean cannot be incremental)
  @@agg_prod = -> (array) do
    array.reduce(:*)
  end

  @@agg_avg = -> (array) do
    array.reduce(:+) / array.size.to_f
  end

  # h2 functions, lambda on two values
  @@h2_product = -> (val1, val2) do
    val1 * val2
  end

  @@h2_avg = -> (val1, val2) do
    (val1 + val2) / 2.0
  end

  @@h2_proba_tconorm = -> (val1, val2) do
    val1 + val2 - val1 * val2
  end

  @@h2_einstein = -> (val1, val2) do
    (val1 + val2) / (1.0 + val1 * val2)
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
      # Computes the intersection between attackes and similar arguments
      intersection = arg1.attackers & arg2.similar.keys
      if intersection.empty?
        arg2.value
      else
        intersection.map! do |node| # for each argument in the intersections
          h2.(arg2.value, node.value) * (2 - arg2.similar[node]) / 2 # value computed
        end
        agg.(intersection)
      end
    end

    def computeV(arg1)
      if arg1.attackers.empty?
        arg1.value
      else
        # for each attackers, computeS, then reduce with h1, then apply g
        g.(arg1.attackers.map {|node| computeS(arg1, node)}.reduce(&h1))
      end
    end
  end
end
