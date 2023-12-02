# frozen_string_literal: true

input = File.read("../inputs/01.txt")

SPELLED_DIGITS = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9"
}

p1 = []
p2 = []

input.each_line do |line|
  p1_digits = line.scan(/(\d)/).flatten
  p2_digits = line.scan(/(?=(#{SPELLED_DIGITS.keys.join("|")}|\d))/).flatten

  p1.append(p1_digits.first + p1_digits.last)
  p2.append(
    (SPELLED_DIGITS[p2_digits.first] || p2_digits.first) + (SPELLED_DIGITS[p2_digits.last] || p2_digits.last)
  )
end

puts p1.map(&:to_i).sum
puts p2.map(&:to_i).sum
