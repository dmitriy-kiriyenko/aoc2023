# frozen_string_literal: true

module Day5
  class Part2 < BaseSolution
    attr_reader :data

    class Mapper
      attr_reader :mappings

      def initialize
        @mappings = []
        yield self
      end

      def add(dst_start, src_start, range)
        mappings << [(src_start..src_start + range - 1), dst_start - src_start]
      end

      def map(seed_range)
        found = false
        covered = []
        uncovered = []
        mappings.each do |(mapping, offset)|
          if mapping.cover?(seed_range)
            covered << (seed_range.begin+offset..seed_range.end+offset)
            found = true
          elsif mapping.cover?(seed_range.begin)
            covered << (seed_range.begin+offset..mapping.end+offset)
            uncovered << (mapping.end+1..seed_range.end)
            found = true
          elsif mapping.cover?(seed_range.end)
            uncovered << (seed_range.begin..mapping.begin-1)
            covered << (mapping.begin+offset..seed_range.end+offset)
            found = true
          elsif seed_range.cover?(mapping)
            uncovered << (mapping.end+1..seed_range.end)
            uncovered << (seed_range.begin..mapping.begin-1)
            covered << (mapping.begin+offset..mapping.end+offset)
            found = true
          end
          break if found
        end
        covered << seed_range unless found

        [covered, uncovered]
      end

      def inspect
        "#<#{self.class}: mappings = #{mappings.inspect}"
      end
    end

    def run
      @data = chomped_lines.to_a
      seed_cache = read_seeds

      all_mappers.each do |mapper|
        next_seed_cache = []
        while seed_cache.any?
          seed_range = seed_cache.pop
          covered, uncovered = mapper.map(seed_range)
          next_seed_cache.append(*covered)
          seed_cache.append(*uncovered)
        end
        seed_cache = next_seed_cache
      end

      seed_cache.map { |r| r.begin }.min
    end

    def read_seeds
      data.first.split(': ').last.split(' ').map(&:to_i).each_slice(2).map do |start, range|
        (start..start + range - 1)
      end
    end

    def all_mappers
      [
        seed_to_soil_map,
        soil_to_fertilizer_map,
        fertilizer_to_water_map,
        water_to_light_map,
        light_to_temperature_map,
        temperature_to_humidity_map,
        humidity_to_location_map
      ]
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
      46
    end
  end
end
