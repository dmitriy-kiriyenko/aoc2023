# frozen_string_literal: true

module Day2
  class Part2 < BaseSolution
    def run
      chomped_lines.map do |line|
        games_string = line.split(': ').last
        power(games_string)
      end.sum
    end

    def power(games_string)
      initial_hash = { red: 0, green: 0, blue: 0 }.with_indifferent_access
      games_string.split('; ').reduce(initial_hash) do |acc, game|
        game.split(', ').reduce(acc) do |acc, pull|
          number, color = pull.split(' ')
          acc[color] <= number.to_i ?
            acc.merge(color => number.to_i) :
            acc
        end
      end.values.reduce(:*)
    end

    def self.expected_result
      2286
    end
  end
end
