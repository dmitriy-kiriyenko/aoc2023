# frozen_string_literal: true

module Day4
  class Part1 < BaseSolution
    def run
      chomped_lines.map do |line|
        winning, existing = line.split(': ').last.split(' | ').map { |s| s.split(' ') }
        power = (winning & existing).size - 1
        power < 0 ? 0 : 2 ** power
      end.sum
    end

    def self.expected_result
      13
    end
  end
end
