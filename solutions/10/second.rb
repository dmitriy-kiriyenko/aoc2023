# frozen_string_literal: true

module Day10
  class Part2 < BaseSolution
    def run
      ax = nil
      ay = nil
      grid = chomped_lines.each_with_index.map do |line, x|
        line.chars.tap do |row|
          if y = row.index('S')
            ax = x
            ay = y
          end
        end
      end
      h = grid.size
      w = grid.first.size

      # rightward downward leftward upward
      dirs = [[0,1],[1,0],[0,-1],[-1,0]]
      happy = ['-7J', '|LJ', '-FL', '|F7']
      s_dirs = []
      (0...dirs.size).each do |i|
        pos = dirs[i]
        bx = ax+pos[0]
        by = ay+pos[1]
        if bx >= 0 && bx < h && by >= 0 && by < w && grid[bx][by].in?(happy[i])
          s_dirs << i
        end
      end

      # rightward downward leftward upward
      transform = {
        [0, '-'] => 0,
        [0, '7'] => 1,
        [0, 'J'] => 3,
        [2, '-'] => 2,
        [2, 'F'] => 1,
        [2, 'L'] => 3,
        [1, '|'] => 1,
        [1, 'L'] => 0,
        [1, 'J'] => 2,
        [3, '|'] => 3,
        [3, 'F'] => 0,
        [3, '7'] => 2
      }

      cur_dir = s_dirs[0]
      cx = ax + dirs[cur_dir][0]
      cy = ay + dirs[cur_dir][1]

      bool_grid = (0...h).map { |_| [false] *  w }
      bool_grid[ax][ay] = true
      while [cx, cy] != [ax, ay]
        bool_grid[cx][cy] = true
        cur_dir = transform[[cur_dir, grid[cx][cy]]]
        cx = cx + dirs[cur_dir][0]
        cy = cy + dirs[cur_dir][1]
      end

      ct = 0
      (0...h).each do |i|
        inn = false
        (0...w).each do |j|
          if bool_grid[i][j]
            if grid[i][j].in?('|JL'.chars) || (grid[i][j] == 'S' && s_dirs.include?(3))
              inn = !inn
            end
          else
            ct += (inn ? 1 : 0)
          end
        end
      end

      ct
    end

    def self.expected_result
      4
    end
  end
end
