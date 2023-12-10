# frozen_string_literal: true

module Day10
  class Part1 < BaseSolution
    extend Memoist

    def run
      start = nil
      @grid = chomped_lines.each_with_index.map do |line, x|
        line.chars.tap do |row|
          y = row.index('S')
          start = [x, y] if y
        end
      end

      dirs_from_start = directions.select do |dir, happy|
        grid(move(start, dir)).in?(happy)
      end.keys

      cur_dir = dirs_from_start.first
      cur_pos = move(start, cur_dir)

      dist = 1
      while cur_pos != start
        dist += 1
        cur_dir = transform[[cur_dir, grid(cur_pos)]]
        cur_pos = move(cur_pos, cur_dir)
      end

      dist / 2
    end

    def grid((x, y))
      if x.in?(x_range) && y.in?(y_range)
        @grid[x][y]
      else
        '.'
      end
    end

    memoize def x_range
      (0...@grid.size)
    end

    memoize def y_range
      (0...@grid.first.size)
    end

    def move((x, y), (dx, dy))
      [x+dx, y+dy]
    end

    memoize def directions
      {
        right => '-7J',
        down => '|LJ',
        left => '-FL',
        up => '|F7'
      }
    end

    memoize def right
      [0, 1]
    end

    memoize def down
      [1, 0]
    end

    memoize def left
      [0, -1]
    end

    memoize def up
      [-1, 0]
    end

    memoize def transform
      {
        [right, '-'] => right,
        [right, '7'] => down,
        [right, 'J'] => up,
        [left, '-'] => left,
        [left, 'F'] => down,
        [left, 'L'] => up,
        [down, '|'] => down,
        [down, 'L'] => right,
        [down, 'J'] => left,
        [up, '|'] => up,
        [up, 'F'] => right,
        [up, '7'] => left
      }
    end

    def self.expected_result
      4
    end
  end
end
