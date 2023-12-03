# frozen_string_literal: true

require 'set'

input = defined?(DATA) ? DATA.read : File.read("../inputs/03.txt")

lines = input.split("\n")
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
  stars = line.scan(/(\*)/).flatten
  star_indices = line.enum_for(:scan, /\*/).map { Regexp.last_match.offset(0).first }

  line_above, line_below = lines[current_line - 1], lines[current_line + 1]

  line_data = []
  get_line_data(line, line_data)
  get_line_data(line_above, line_data) if line_above
  get_line_data(line_below, line_data) if line_below

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

puts gears.sum

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
