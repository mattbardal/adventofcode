# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/05.txt")

seeds, *maps = input.split("\n\n")
seeds = seeds.split.slice(1..).map(&:to_i)
maps = maps.map { |m| m.split.map(&:to_i).slice(2..) }

lowest_loc = nil

seeds.map do |seed|
  current_loc = maps.reduce(seed) do |v, current_map|
    found_mapping = nil

    current_map.each_slice(3) do |dest, src, range|
      if v >= src && v < (src + range)
        found_mapping = [dest, src, range]
        break
      end
    end

    dest, src, range = found_mapping unless found_mapping.nil?
    found_mapping ? v - src + dest : v
  end
  lowest_loc = current_loc if lowest_loc.nil? || current_loc < lowest_loc
end

print lowest_loc

__END__
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
