# frozen_string_literal: true

class Card
  attr_accessor :type, :strength

  CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"].each_with_index.to_h { |c, idx| [c, idx] }
  JOKER_RULE_CARDS = ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"].each_with_index.to_h { |c, idx| [c, idx] }
  def initialize(card_str, joker_rule=false)
    @type = card_str
    @strength = joker_rule ? JOKER_RULE_CARDS[card_str] : CARDS[card_str]
  end
end
