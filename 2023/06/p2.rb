# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/06.txt")

time, distance = input.split("\n").map(&:split).map { _1[1..].reduce(&:+).to_i }
wins = 0

(0..time).each do |t_held|
  t_total = t_held == 0 ? distance + t_held : distance / t_held + t_held
  wins += 1 if t_total < time
end

print wins

__END__
Time:      7  15   30
Distance:  9  40  200
