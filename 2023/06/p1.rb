# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/06.txt")

times, distances = input.split("\n").map(&:split).map { _1[1..].map(&:to_i) }

t_d = times.each_with_index.map  { |t, i| [t, distances[i]] }
count_wins = []

t_d.each do |time, distance|
  wins = 0
  (0..time).each do |t_held|
    t_total = t_held == 0 ? distance + t_held : distance / t_held + t_held
    wins += 1 if t_total < time
  end
  count_wins.append(wins)
end

print count_wins.reduce(&:*)

__END__
Time:      7  15   30
Distance:  9  40  200
