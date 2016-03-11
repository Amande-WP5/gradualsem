module Gradualsem
  def simple_att(value)

  end

  def product_tnorm_comb(val1, val2)
    val1 * val2
  end

  def proba_sum_tconorm_agg(val1, val2)
    val1 + val2 - val1 * val2
  end

  def simple_restr(val)
    1 - val
  end

  class Semantics
    attr_reader :graph, :att, :comb, :agg, :restr, :prox

    def initialize(graph, att, comb, agg, restr, prox)
      @graph = graph
      @comb = comb
      @agg = agg
      @restr = restr
      @prox = prox
    end

    def compute

    end
  end
end
