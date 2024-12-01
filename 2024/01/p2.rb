# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/01.txt")

l, r = [], []
input.each_line.map { |line| line.split.map(&:to_i) }.each { |a, b| l << a; r << b }
p2 = l.map { r.count(_1) * _1 }.sum

puts p2

__END__
3   4
4   3
2   5
1   3
3   9
3   3
