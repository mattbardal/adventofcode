# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/03.txt")

SYMBOLS = ["@", "#", "$", "%", "&", "*", "_", "-", "+", "=", "/"]
lines = input.split("\n")
numbers_to_sum = []

lines.each_with_index do |line, current_line|
  numbers = line.scan(/\d+/)
  indices = line.enum_for(:scan, /\d+/).map { Regexp.last_match.offset(0).first }

  line_above, line_below = lines[current_line - 1], lines[current_line + 1]

  numbers.each_with_index do |number, i|
    start_i = indices[i]
    end_i = start_i + number.length - 1

    indices_to_check = (start_i - 1..end_i + 1).to_a

    if indices_to_check.any? do |index|
      (line_above && SYMBOLS.include?(line_above[index])) ||
        (line_below && SYMBOLS.include?(line_below[index])) ||
        SYMBOLS.include?(line[start_i - 1]) ||
        SYMBOLS.include?(line[end_i + 1])
    end
      numbers_to_sum << number
    end
  end
end

puts numbers_to_sum.map(&:to_i).sum

__END__
467+.114..
...*......
..35..633.
......#...
617*....75
.....+.58.
..592.....
......755.
...$.*....
.664.598..
