# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/01.txt")

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

p2 = []

input.each_line do |line|
  p2_digits = line.scan(/(?=(#{SPELLED_DIGITS.keys.join("|")}|\d))/).flatten
  p2.append(
    (SPELLED_DIGITS[p2_digits.first] || p2_digits.first) + (SPELLED_DIGITS[p2_digits.last] || p2_digits.last)
  )
end

puts p2.map(&:to_i).sum

__END__
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
