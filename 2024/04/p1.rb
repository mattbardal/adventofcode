# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/04.txt")

arr = input.split.map(&:chars)

def horizontal(str)
  str.scan(/XMAS/).count + str.scan(/SAMX/).count
end

def vertical_strings(arr)
  arr.transpose.map(&:join)
end

def diagonal_strings(arr)
  (0...arr.size).map do |i|
    (0...arr.size - i).map { |j| arr[i + j][j] }.join
  end +
  (1...arr.size).map do |i|
    (0...arr.size - i).map { |j| arr[j][i + j] }.join
  end
end

horizontal = arr.map { |row| horizontal(row.join) }.sum
vertical = vertical_strings(arr).map { |row| horizontal(row) }.sum
diagonal_lr = diagonal_strings(arr).map { |row| horizontal(row) }.sum
diagonal_rl = diagonal_strings(arr.map { |row| row.reverse }).map { |row| horizontal(row) }.sum

puts vertical + horizontal + diagonal_lr + diagonal_rl

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
