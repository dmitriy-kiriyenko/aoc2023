# frozen_string_literal: true

module Day9
  class Part1 < BaseSolution
    def run
      extrapolated = chomped_lines.map do |line|
        numbers = line.split(' ').map(&:to_i)

        differences = []
        difference = numbers

        until difference.all?(&:zero?)
          difference = difference.each_cons(2).map { |(l, r)| r-l }
          differences << difference
        end

        differences.map(&:last).sum + numbers.last
      end

      extrapolated.sum
    end

    def self.expected_result
      114
    end
  end
end
