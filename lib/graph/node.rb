module Gradualsem
  class Node
    attr_accessor :sim, :attacking, :attackers, :supporting, :supporters, :default_value

    def initialize(default_value=0.0)
      @sim = new Hash(0.0)
      @attacking = []
      @attackers = []
      @supporting = []
      @supporters = []
      @default_value = default_value
    end

    def add_attacking(*node)
      @attacking += *node
    end

    def add_attackers(*node)
      @attackers += *node
    end

    def add_supporting(*node)
      @supporting += *node
    end

    def add_supporters(*node)
      @supporters += *node
    end
  end
end
