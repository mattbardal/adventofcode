# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/08.txt")

directions, nodes =  input.split("\n\n")
directions = directions.chars
nodes = nodes.split("\n").map { |n| n.split(" = ") }.map { |s, n| [s, n.gsub(/\(|\)/, '')] }
m = {}

nodes.each do |c, n|
  m[c] = n.split(", ")
end

nodes = m.keys.find_all { _1[-1] == "A" }
node_steps = []

directions_cycle = directions.cycle

nodes.each do |node|
  steps = 0
  until node[-1] == "Z" do
    direction = directions_cycle.next
    current_options = m[node]
    node = (direction == "L") ? current_options.first : current_options.last
    steps += 1
  end
  node_steps.append(steps)
end

print node_steps.reduce(:lcm)

__END__
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
