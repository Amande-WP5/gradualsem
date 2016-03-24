module Gradualsem
  class Node
    attr_accessor :attacking, :attackers, :similar, :default_value

    def initialize(default_value=0.0)
      @sim = new Hash(0.0)
      @attacking = []
      @attackers = []
      @default_value = default_value
    end

    def add_attacking(*nodes)
      @attacking += *nodes
    end

    def add_attackers(*nodes)
      @attackers += *nodes
    end

    def add_similar(node, value)
      @similar[node] = value
      node.@similar[self] = value
    end

    def value
      @default_value
    end
  end
end
