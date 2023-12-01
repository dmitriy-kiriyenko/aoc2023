# frozen_string_literal: true

module Day1
  class Part1 < BaseSolution
    def run
      chomped_lines.map do |line|
        digits = line.chars.grep(/\d/)
        (digits.first + digits.last).to_i
      end.sum
    end

    def self.expected_result
      142
    end
  end
end
