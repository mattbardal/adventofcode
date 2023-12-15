# frozen_string_literal: true

class Range
  def intersection(other)
    return nil if (self.max < other.begin || other.max < self.begin)
    s = [self.begin, other.begin].max
    e = [self.max, other.max].min
    s..e
  end
end

input = defined?(DATA) ? DATA.read : File.read("../inputs/05.txt")

seeds, *maps = input.split("\n\n")

seeds = seeds.split.slice(1..).map(&:to_i)
seed_ranges = seeds.each_slice(2).map { _1..(_1 + _2) }

maps = maps.map do |m|
  m.split.map(&:to_i).slice(2..).each_slice(3).map do
    dest, src, range = _1
    [src..src + range, dest]
  end
end

def process_seed_range(seed_range, idx, maps)
  return [seed_range] if maps[idx].nil?

  current_map = maps[idx]
  overlapped_mappings = current_map.filter { |m| seed_range.intersection(m.first) }
  return process_seed_range(seed_range, idx + 1, maps) if overlapped_mappings.empty?

  options = []

  overlapped_mappings.each do |overlapped_mapping|
    difference = overlapped_mapping[1] - overlapped_mapping[0].begin
    new_seed_range = seed_range.intersection(overlapped_mapping[0])

    left = (seed_range.begin)..(new_seed_range.begin) if seed_range.begin < new_seed_range.begin
    right = (seed_range.end)..(new_seed_range.end) if seed_range.end < new_seed_range.end
    new_seed_range = (difference + new_seed_range.begin)..(difference + new_seed_range.end)

    options.append([new_seed_range, left, right].compact)
  end

  options.flatten.map { |sr| process_seed_range(sr, idx + 1, maps) }
end

print seed_ranges.map { |sr| process_seed_range(sr, 0, maps)}.flatten.map(&:begin).min

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
