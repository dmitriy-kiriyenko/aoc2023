# frozen_string_literal: true

module Day5
  class Part1 < BaseSolution
    attr_reader :data

    class Mapper
      attr_reader :mappings

      def initialize
        @mappings = []
        yield self
        mappings.sort
      end

      def add(dst_start, src_start, range)
        mappings << [src_start, src_start + range - 1, dst_start - src_start]
      end

      def map(src)
        delta = mappings.find { |mapping|
          mapping[0] <= src && mapping[1] >= src
        }&.last || 0
        src + delta
      end

      def inspect
        "#<#{self.class}: mappings = #{mappings.inspect}"
      end
    end

    def run
      @data = chomped_lines.to_a
      seeds.map do |seed|
        [
          seed_to_soil_map,
          soil_to_fertilizer_map,
          fertilizer_to_water_map,
          water_to_light_map,
          light_to_temperature_map,
          temperature_to_humidity_map,
          humidity_to_location_map
        ].reduce(seed) do |acc, mapper|
          mapper.map(acc)
        end
      end.min
    end

    def seeds
      data.first.split(': ').last.split(' ').map(&:to_i)
    end

    def seed_to_soil_map
      read_map('seed-to-soil map:')
    end

    def soil_to_fertilizer_map
      read_map('soil-to-fertilizer map:')
    end

    def fertilizer_to_water_map
      read_map('fertilizer-to-water map:')
    end

    def water_to_light_map
      read_map('water-to-light map:')
    end

    def light_to_temperature_map
      read_map('light-to-temperature map:')
    end

    def temperature_to_humidity_map
      read_map('temperature-to-humidity map:')
    end

    def humidity_to_location_map
      read_map('humidity-to-location map:')
    end

    def read_map(header)
      idx = data.index(header)

      Mapper.new do |m|
        while (line = data[idx += 1]).present?
          m.add(*line.split(' ').map(&:to_i))
        end
      end
    end

    def self.expected_result
      35
    end
  end
end
