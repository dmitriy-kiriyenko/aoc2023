# frozen_string_literal: true

module Day3
  class Part1 < BaseSolution
    def run
      @board = chomped_lines.to_a
      @board.each_with_index.flat_map do |line, idx|
        numbers = []
        line.scan(/\d+/) do |c|
          numbers << [c, Regexp.last_match.offset(0)[0]]
        end
        numbers.select { |n| check?(n, idx) }.map(&:first).map(&:to_i)
      end.sum
    end

    def check?(n, idx)
      x_range = (([n.last - 1, 0].max)..(n.last + n.first.size))
      connect_top = idx > 0 && @board[idx - 1].chars[x_range].any? { |c| char?(c) }
      connect_bottom = idx < @board.size - 1 && @board[idx + 1].chars[x_range].any? { |c| char?(c)}
      middle = @board[idx]
      connect_middle = char?(middle[x_range.begin]) || char?(middle[x_range.end])

      connect_top || connect_bottom || connect_middle
    end

    def char?(ch)
      ch && ch != '.' && !ch.match(/\d/)
    end

    def self.expected_result
      4361
    end
  end
end
