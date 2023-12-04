# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/04.txt")

cards_mapping, card_counts = {}, {}
total_scratchcards = 0

input.each_line do |line|
  count = 0
  card, line = line.split(": ")
  wins, digits = line.split(" | ")

  card_id = card.split.last.to_i
  wins = wins.split

  digits.split.each { |digit| count += 1 if wins.include?(digit) }

  card_counts[card_id] = count
  cards_mapping[card_id] = (card_id + 1 .. card_id + count).to_a

  total_scratchcards += (count + 1)
end

scratchcard_copies = cards_mapping.values.flatten

scratchcard_copies.each do |card_id|
  cards_mapping[card_id].each { |copy_id| scratchcard_copies.append(copy_id) }
  total_scratchcards += card_counts[card_id]
end

puts total_scratchcards

__END__
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
