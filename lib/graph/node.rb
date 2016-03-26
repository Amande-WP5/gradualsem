module Gradualsem
  class Node
    attr_reader :attackers, :attacked, :similar
    attr_accessor :value

    def initialize(default_value=0.0)
      @similar = Hash.new(0.0)
      @attacked  = []
      @attackers = []
      @value = default_value
    end

    # Adds in self that it is attacked by node.
    # It automatically takes care add in node that it attacks self.
    def add_attackers(*nodes)
      @attackers += nodes
      nodes.each do |n|
        n.attacked << self
      end
    end

    def add_similar(node, value)
      @similar[node] = value
      node.similar[self] = value
    end
  end
end
