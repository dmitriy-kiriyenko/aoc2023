require_relative 'file_reader'

class BaseSolution
  include FileReader

  def initialize(path)
    @path = path
  end
end
