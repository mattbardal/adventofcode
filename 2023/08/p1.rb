# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/08.txt")

directions, nodes =  input.split("\n\n")
directions = directions.chars
nodes = nodes.split("\n").map { |n| n.split(" = ") }.map { |s, n| [s, n.gsub(/\(|\)/, '')] }
m = {}

nodes.each do |c, n|
  m[c] = n.split(", ")
end

node = "AAA"
steps = 0

directions_cycle = directions.cycle

until node == "ZZZ"
  direction = directions_cycle.next
  current_options = m[node]
  node = (direction == "L") ? current_options.first : current_options.last
  steps += 1
end

puts steps

__END__
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
