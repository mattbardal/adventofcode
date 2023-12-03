# frozen_string_literal: true

input = File.read("../inputs/03.txt")

SYMBOLS = ["@", "#", "$", "%", "&", "*", "_", "-", "+", "=", "/"]
lines = input.split("\n")
numbers_to_sum = []
gears = []

def get_line_data(line, line_data)
  numbers = line.scan(/\d+/)
  indices = line.enum_for(:scan, /\d+/).map { Regexp.last_match.offset(0).first }

  numbers.each_with_index do |n, i|
    starting_index = indices[i]
    ending_index = starting_index + n.length - 1
    line_data.append([n, (starting_index .. ending_index).to_a])
  end
end

lines.each_with_index do |line, current_line|
  numbers = line.scan(/\d+/)
  indices = line.enum_for(:scan, /\d+/).map { Regexp.last_match.offset(0).first }

  stars = line.scan(/(\*)/).flatten
  star_indices = line.enum_for(:scan, /\*/).map { Regexp.last_match.offset(0).first }

  line_above, line_below = lines[current_line - 1], lines[current_line + 1]

  line_data = []
  get_line_data(line, line_data)
  get_line_data(line_above, line_data) if line_above
  get_line_data(line_below, line_data) if line_below

  # Part 1
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

  # Part 2
  stars.each_with_index do |star, i|
    star_idx = star_indices[i]
    current_gear_numbers = Set.new

    indices_to_check = (star_idx - 1..star_idx + 1).to_a

    indices_to_check.each do |idx|
      line_data.each do |number, indices|
        current_gear_numbers.add(number) if indices.include?(idx)
      end
    end

    gears.push(current_gear_numbers.map(&:to_i).inject(:*)) unless current_gear_numbers.size < 2
  end
end

puts numbers_to_sum.map(&:to_i).sum
puts gears.sum
