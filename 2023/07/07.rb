# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/07.txt")

require_relative 'card.rb'
require_relative 'hand.rb'

hands, bids = input.split("\n").map(&:split).transpose
bids = bids.map(&:to_i)

p1_hands = hands.each_with_index.map { |h, i| Hand.new(h.chars, bids[i], 0, joker_rule=false) }
p2_hands = hands.each_with_index.map { |h, i| Hand.new(h.chars, bids[i], 0, joker_rule=true) }

def handle_hands(hands)
  sorted_hands = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [] }
  hands.each do |h|
    case
    when h.five_of_a_kind? then sorted_hands[0] << h
    when h.four_of_a_kind? then sorted_hands[1] << h
    when h.full_house? then sorted_hands[2] << h
    when h.three_of_a_kind? then sorted_hands[3] << h
    when h.two_pairs? then sorted_hands[4] << h
    when h.one_pair? then sorted_hands[5] << h
    when h.high_card? then sorted_hands[6] << h
    end
  end

  current_rank = hands.count

  sorted_hands.each do |_, hs|
    if hs.length == 1
      hs.first.rank = current_rank
      current_rank -= 1
    else
      hs.sort! { |a, b| a.cmp(b) }.each do |h|
        h.rank = current_rank
        current_rank -= 1
      end
    end
  end

  hands.map { |h| h.rank * h.bid }.sum
end

puts handle_hands(p1_hands)
puts handle_hands(p2_hands)

__END__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
