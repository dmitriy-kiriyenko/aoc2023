# frozen_string_literal: true

module Day8
  class Part1 < BaseSolution
    def run
      dirs, _, *nodes = chomped_lines
      dirs = dirs.chars.cycle
      node_map = nodes.map do |node|
        k, v = node.split(' = ')
        l, r = v.gsub(/[()]/, '').split(', ')
        [k, {'L' => l, 'R' => r}]
      end.to_h

      current = 'AAA'
      steps = 0

      until current == 'ZZZ'
        steps += 1
        current = node_map[current][dirs.next]
      end

      steps
    end

    def self.expected_result
      2
    end
  end
end
