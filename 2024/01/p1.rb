# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/01.txt")

l, r = [], []
input.each_line.map { |line| line.split.map(&:to_i) }.each { |a, b| l << a; r << b }
p1 = l.sort.zip(r.sort).map { |a, b| (a - b).abs }.sum

puts p1

__END__
3   4
4   3
2   5
1   3
3   9
3   3
