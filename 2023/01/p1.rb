# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/01.txt")

p1 = []

input.each_line do |line|
  p1_digits = line.scan(/(\d)/).flatten
  p1.append(p1_digits.first + p1_digits.last)
end

puts p1.map(&:to_i).sum

__END__
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
