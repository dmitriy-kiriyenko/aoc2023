# frozen_string_literal: true

module FileReader
  extend self

  def read_file(path = @path)
    File.read(path)
  end

  def chomped_lines(path = @path)
    read_file(path).lines.map(&:chomp)
  end

  def for_each_line(path = @path)
    File.readlines(path).each do |line|
      yield(line.strip)
    end
  end
end
