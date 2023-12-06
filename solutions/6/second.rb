# frozen_string_literal: true

module Day6
  class Part2 < BaseSolution
    include MathHelpers

    def run
      time, distance = chomped_lines.map do |line|
        line.split(/:\s+/).last.split(/\s+/).join.to_i
      end

      # declared in lib/math_helpers.rb
      x1, x2 = solve_quadratic_equation(1, -time, distance)
      floor = float_is_int?(x1) ? x1.to_i + 1 : x1.ceil
      ceil = float_is_int?(x2) ? x2.to_i - 1 : x2.floor
      ceil - floor + 1
    end

    def self.expected_result
      71503
    end
  end
end
