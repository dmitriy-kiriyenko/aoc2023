# frozen_string_literal: true

module Day3
  class Part2 < BaseSolution
    def run
      @board = chomped_lines.to_a
      @numbers_map = {}
      @board.each_with_index do |line, idx|
        numbers = []
        line.scan(/\d+/) do |c|
          numbers << [c, Regexp.last_match.offset(0)[0]]
        end
        numbers.each do |(num, i)|
          x_range = (([i - 1, 0].max)..(i + num.size))
          (@numbers_map[idx] ||= []) << [x_range, num.to_i]
        end
      end

      @board.each_with_index.flat_map do |line, idx|
        star_positions = []
        line.scan(/\*/) do |c|
          star_positions << Regexp.last_match.offset(0)[0]
        end
        star_positions.map { |st| get_parts(st, idx) }.select do |parts|
          parts.size == 2
        end.map { |(f, s)| f * s }
      end.sum
    end

    def get_parts(star_position, idx)
      (idx-1..idx+1).flat_map do |i|
        row = @numbers_map[i]
        next([]) unless row
        row.select { |num| num.first.include?(star_position) }.map(&:last)
      end
    end

    def self.expected_result
      467835
    end
  end
end
