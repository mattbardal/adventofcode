# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/03.txt")

puts input.scan(/mul\((\d+),(\d+)\)/).map { |a, b| a.to_i * b.to_i }.sum

__END__
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
