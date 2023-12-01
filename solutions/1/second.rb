# frozen_string_literal: true

module Day1
  class Parser
    attr_reader :dictionary, :regexp

    def initialize
      words = %w[one two three four five six seven eight nine]
      @dictionary = words.zip((1..words.size)).to_h
      @regexp = Regexp.union(*dictionary.keys, *dictionary.values.map(&:to_s))
    end

    def parse(line)
      res = line.match(/(#{regexp}).*(#{regexp})/) || line.match(/(#{regexp})/)
      return unless res

      decoded = res.captures.map { |c| decode(c) }
      decoded.first * 10 + decoded.last
    end

    def decode(capture)
      dictionary.key?(capture) ? dictionary[capture] : capture.to_i
    end
  end

  class Part2 < BaseSolution
    def run
      chomped_lines.map do |line|
        parser.parse(line)
      end.sum
    end

    def parser
      @parser ||= Parser.new
    end

    def self.expected_result
      281
    end
  end
end
