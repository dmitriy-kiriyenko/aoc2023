# frozen_string_literal: true

module Day11
  class Part1 < BaseSolution
    def run
      @grid = chomped_lines.map do |line|
        line.chars
      end

      @galaxies = []
      @grid.each_with_index do |line, x|
        line.each_with_index do |c, y|
          @galaxies << [x, y] if c == '#'
        end
      end

      expand! 2

      @galaxies.combination(2).sum do |c1, c2|
        (c1.first - c2.first).abs + (c1.last - c2.last).abs
      end
    end

    def expand!(times)
      expand_rows!(times)
      expand_columns!(times)
    end

    def expand_rows!(times)
      galaxies_offsets = Array.new(@galaxies.size, 0)
      (0...@grid.size).each do |i|
        if @grid[i].all? { |x| x == '.' }
          @galaxies.each_with_index do |galaxy, idx|
            if galaxy.first > i
              galaxies_offsets[idx] += (times - 1)
            end
          end
        end
      end

      @galaxies.zip(galaxies_offsets).each do |galaxy, offset|
        galaxy[0] += offset
      end
    end

    def expand_columns!(times)
      galaxies_offsets = Array.new(@galaxies.size, 0)
      (0...@grid.first.size).each do |i|
        if all_column?(i) { |x| x == '.' }
          @galaxies.each_with_index do |galaxy, idx|
            if galaxy.last > i
              galaxies_offsets[idx] += (times - 1)
            end
          end
        end
      end

      @galaxies.zip(galaxies_offsets).each do |galaxy, offset|
        galaxy[-1] += offset
      end
    end

    def all_column?(col)
      @grid.each do |line|
        return false unless yield(line[col])
      end
      true
    end

    def self.expected_result
      374
    end
  end
end
