# frozen_string_literal: true

module Day4
  class Part2 < BaseSolution
    def run
      duplicates_counter = {}
      list = chomped_lines
      list.each_with_index do |line, idx|
        winning, existing = line.split(': ').last.split(' | ').map { |s| s.split(' ') }
        won = (winning & existing).size
        incr = duplicates_counter[idx].to_i + 1
        if won > 0
          (1..won).each do |di|
            duplicates_counter[idx + di] ||= 0
            duplicates_counter[idx + di] += incr
          end
        end
      end

      list.size + duplicates_counter.values.sum
    end

    def self.expected_result
      30
    end
  end
end
