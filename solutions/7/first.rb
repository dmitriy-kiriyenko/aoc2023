# frozen_string_literal: true

module Day7
  class Part1 < BaseSolution
    class Hand
      attr_reader :card_chars, :groups, :card_powers
      CARD_POWERS = %w[A K Q J T 9 8 7 6 5 4 3 2]

      def initialize(cards)
        @card_chars = cards.chars
        @groups = card_chars.tally.values.sort_by(&:-@) # :-D
        @card_powers = card_chars.map { |c| 1000-CARD_POWERS.index(c) }
      end

      def <=>(other)
        [groups, card_powers] <=> [other.groups, other.card_powers]
      end
    end

    def run
      chomped_lines.map do |line|
        hand, bid = line.split(' ')
        hand = Hand.new(hand)
        bid = bid.to_i
        [hand, bid]
      end.sort_by do |(hand, bid)|
        hand
      end.each_with_index.map do |(hand, bid), index|
        bid * (index + 1)
      end.sum
    end

    def self.expected_result
      6440
    end
  end
end
