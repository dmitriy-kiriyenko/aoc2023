# frozen_string_literal: true

module Day9
  class Part2 < BaseSolution
    def run
      extrapolated = chomped_lines.map do |line|
        numbers = line.split(' ').map(&:to_i)

        differences = []
        difference = numbers

        until difference.all?(&:zero?)
          difference = difference.each_cons(2).map { |(l, r)| r-l }
          differences << difference
        end

        numbers.first - differences.reverse.map(&:first).reduce(0) { |acc, i| i - acc }
      end

      extrapolated.sum
    end

    def self.expected_result
      2
    end
  end
end
