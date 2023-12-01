module StrUtils
  extend self

  def indented_lines(prefix, *output)
    output.flatten.flat_map(&:lines).map { |s| "#{prefix}#{s.chomp}" }.join("\n")
  end
end
