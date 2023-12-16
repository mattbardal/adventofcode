# frozen_string_literal: true

class Hand
  attr_accessor :cards, :bid, :value, :rank

  def initialize(cards_arr, bid = 0, rank = 0, joker_rule=false)
    @value = cards_arr.map { |c| c.is_a?(Card)? 0 : (joker_rule ? Card::JOKER_RULE_CARDS[c] : Card::CARDS[c]) }
    remove_jokers(cards_arr) if joker_rule
    @cards = cards_arr.map { |c| c.is_a?(Card) ? c : Card.new(c, joker_rule=joker_rule) }
    @bid = bid
    @rank = rank
  end

  def high_card?
    @cards.sort_by { |c| c.strength }.last
  end

  def full_house?
    three = three_of_a_kind?
    remaining = Hand.new(@cards - three).one_pair? if three
    if remaining
      return @cards
    end
  end

  def five_of_a_kind?
    n_of_a_kind(5)
  end

  def four_of_a_kind?
    n_of_a_kind(4)
  end

  def three_of_a_kind?
    n_of_a_kind(3)
  end

  def two_pairs?
    first_pair = one_pair?
    second_pair = Hand.new(@cards - first_pair).one_pair? if first_pair
    if second_pair
      return first_pair + second_pair
    else
      false
    end
  end

  def one_pair?
    n_of_a_kind(2)
  end

  def to_s
    @cards.map { _1.type }
  end

  def cmp(other)
    value.each_with_index do |v, i|
      if v > other.value[i]
        return -1
      elsif v < other.value[i]
        return 1
      end
    end
    # return 0
  end

  private

  def n_of_a_kind(n)
    Card::CARDS.values.each do |v|
      if (kind = @cards.select { |c| c.strength == v }).size == n
        return kind
      end
    end
    return false
  end

  def remove_jokers(cards)
    joker = "J"
    most_common_element = cards.group_by { |e| e }.max_by { |_, v| v.length }&.first

    if most_common_element == joker
      filtered_array = cards.reject { |e| e == most_common_element }
      second_most_common_element = filtered_array.group_by { |e| e }.max_by { |_, v| v.length }&.first
    end

    cards.map! do |c|
      if c == joker
        most_common_element != joker ? most_common_element : (second_most_common_element || most_common_element)
      else
        c
      end
    end
  end
end
