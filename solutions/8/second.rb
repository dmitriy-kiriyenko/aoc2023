# frozen_string_literal: true

module Day8
  class Part2 < BaseSolution
    def run
      dirs, _, *nodes = chomped_lines
      dirs = dirs.chars.cycle
      node_map = nodes.map do |node|
        k, v = node.split(' = ')
        l, r = v.gsub(/[()]/, '').split(', ')
        [k, {'L' => l, 'R' => r}]
      end.to_h

      starts = node_map.keys.select { |k| k.end_with?('A') }

      starts.reduce(1) do |acc, current|
        steps = 0

        until current.end_with?('Z')
          steps += 1
          current = node_map[current][dirs.next]
        end

        acc.lcm(steps)
      end
    end

    def self.expected_result
      6
    end
  end
end
