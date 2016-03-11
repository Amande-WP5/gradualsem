require "set"

module Gradualsem
  class Graph
    attr_accessor :nodes

    def initialize
      @nodes = {}
    end

    def add_nodes(*node)
      @nodes += *node
    end

    def load_from_file(filename)
      File.open(filename, "r") do |file|
        file.each_line do |line|
          if line.start_with? "arg"
            @nodes[line.match(/arg\((.*)\)/)[1]] = Node.new
          end

          if line.start_with? "att"
            line.match(/att\((.*), (.*)\)/).do |m|
              @nodes[m[1]].add_attacking(@nodes[m[2]])
              @nodes[m[2]].add_attackers(@nodes[m[1]])
            end
          end

          if line.start_with? "support"
            line.match(/support\((.*), (.*)\)/).do |m|
              @nodes[m[1]].add_supporting(@nodes[m[2]])
              @nodes[m[2]].add_supporters(@nodes[m[1]])
            end
          end

          if line.start_with? "sim"
            line.match(/sim\((.*), (.*), (.*)\)/).do |m|
              sim = m[3].to_f
              @nodes[m[1]].sim[@nodes[m[2]]] = sim
              @nodes[m[2]].sim[@nodes[m[1]]] = sim
            end
          end
        end
      end
    end
  end
end
