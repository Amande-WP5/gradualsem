#! env ruby

require_relative "lib/gradualsem"

include Gradualsem
# An example with 5 arguments such as:
# a -> b -> c -> e  and (c,d) are similar with 0.6
#      |         ^
#      |         |
#      -> d -----

# Arguments construction
a = Gradualsem::Node.new(1.0)
b = Gradualsem::Node.new(1.0)
c = Gradualsem::Node.new(1.0)
d = Gradualsem::Node.new(1.0)
e = Gradualsem::Node.new(1.0)

# Graph building (useless if arguments are manually built)
graph = Gradualsem::Graph.new(a,b,c,d,e)

# Attacks and similarity
b.add_attackers(a)
c.add_attackers(b)
d.add_attackers(b)
e.add_attackers(c,d)
c.add_similar(d, 0.6)

# A semantics with
# Agg = sum
# g   = Categorizer
# h1  = Categorizer
# h2  = product

# The name of the function as to be given.
sem = Gradualsem::Semantics.new(@@agg_sum, @@g_cat, @@h1_cat, @@h2_product)

# Computes the value for each argument.
# The order of computation is at the discretion of the user.
a.value = sem.computeV(a)
b.value = sem.computeV(b)
c.value = sem.computeV(c)
d.value = sem.computeV(d)
e.value = sem.computeV(e)