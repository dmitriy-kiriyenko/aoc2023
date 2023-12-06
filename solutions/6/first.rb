# frozen_string_literal: true

module Day6
  class Part1 < BaseSolution
    include MathHelpers

    def run
      time, distance = chomped_lines.map do |line|
        line.split(/:\s+/).last.split(/\s+/).map(&:to_i)
      end
      time_and_distance = time.zip(distance)

      time_and_distance.map do |(t, d)|
        x1, x2 = solve_quadratic_equation(1, -t, d)
        floor = float_is_int?(x1) ? x1.to_i + 1 : x1.ceil
        ceil = float_is_int?(x2) ? x2.to_i - 1 : x2.floor
        ceil - floor + 1
      end.reduce(:*)
    end

    def self.expected_result
      288
    end
  end
end
