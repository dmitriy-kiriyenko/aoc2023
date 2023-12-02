# frozen_string_literal: true

module Day2
  class Part1 < BaseSolution
    BAG = {
      red: 12,
      green: 13,
      blue: 14
    }.with_indifferent_access

    def run
      chomped_lines.map do |line|
        id, games_string = line.split(': ')
        possible = games_string.split('; ').all? { |g| check(g) }
        possible ? id.split(' ').last.to_i : 0
      end.sum
    end

    def check(game)
      game.split(', ').all? do |pull|
        number, color = pull.split(' ')
        number.to_i <= BAG[color]
      end
    end

    def self.expected_result
      8
    end
  end
end
