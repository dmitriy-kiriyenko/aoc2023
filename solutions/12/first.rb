module Day12
  class Part1 < BaseSolution
    def run
      data = chomped_lines.map do |line|
        raw_dots, raw_blocks = line.split
        [raw_dots.chars, raw_blocks.split(',').map(&:to_i)]
      end

      data.sum do |(dots, blocks)|
        score(dots, blocks, 0, 0, 0)
      end
    end

    def score(dots, blocks, idx, block_idx, current)
      if idx == dots.size
        finish = (block_idx == blocks.size && current == 0)
        match = (block_idx == blocks.size - 1 && blocks[block_idx] == current)
        return finish || match ? 1 : 0
      end

      res = 0
      ['.', '#'].each do |c|
        if dots[idx] == c || dots[idx] == '?'
          if c == '.' && current == 0
            res += score(dots, blocks, idx+1, block_idx, 0)
          elsif c == '.' && current > 0 && block_idx < blocks.size && blocks[block_idx] == current
            res += score(dots, blocks, idx + 1, block_idx + 1, 0)
          elsif c == '#'
            res += score(dots, blocks, idx + 1, block_idx, current + 1)
          end
        end
      end
      res
    end

    def self.expected_result
      21
    end
  end
end
