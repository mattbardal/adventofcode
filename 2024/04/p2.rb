# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/04.txt")

arr = input.split.map(&:chars)

def x_mas?(str)
  str.match?(/SAM/) || str.match?(/MAS/)
end

a_map = arr.each_with_index.flat_map do |row, i|
  row.each_with_index.map { |cell, j| [i, j] if cell == "A" && (i != 0 && i != arr.size - 1 && j != 0 && j != arr.size - 1) }.compact
end

sum = a_map.count do |i, j|
  str_1 = arr[i - 1][j - 1] + "A" + arr[i + 1][j + 1]
  str_2 = arr[i - 1][j + 1] + "A" + arr[i + 1][j - 1]

  x_mas?(str_1) && x_mas?(str_2)
end

puts sum

__END__
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
