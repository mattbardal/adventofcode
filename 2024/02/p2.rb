# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/02.txt")

def remove_at(arr, i)
  arr = arr.dup
  arr.delete_at(i)
  arr
end

def safe?(arr)
  (arr.each_cons(2).all? { |l, r| l < r && (r - l) <= 3 } ||
    arr.each_cons(2).all? { |l, r| l > r && (l - r) <= 3 })
end

puts input.each_line.map { |line| line.split.map(&:to_i) }.count { |arr| safe?(arr) || arr.each_with_index.any? { |_, i| safe?(remove_at(arr, i)) } }

__END__
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
