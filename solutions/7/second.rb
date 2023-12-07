# frozen_string_literal: true

module Day7
  class Part2 < BaseSolution
    class Hand
      attr_reader :card_chars, :groups, :card_powers
      CARD_POWERS = %w[A K Q T 9 8 7 6 5 4 3 2 J]

      def initialize(cards)
        @card_chars = cards.chars
        @groups = get_groups
        @card_powers = card_chars.map { |c| 1000-CARD_POWERS.index(c) }
      end

      def get_groups
        counter = card_chars.tally
        return [5] if counter.size == 1 # simples way to eliminate 'all jokers' case

        jokers = counter.delete('J')
        real = counter.values.sort_by(&:-@) # :-D
        return real unless jokers

        real[0] += jokers
        real
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
      5905
    end
  end
end
