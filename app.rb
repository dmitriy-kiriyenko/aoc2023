# frozen_string_literal: true

require('bundler')
Bundler.require
require_all('lib')
require_all('solutions')

raise('Please provide Day and Part args like `./run 1 1`') if ARGV[0].nil? || ARGV[1].nil?

day = ARGV[0].to_i
part = ARGV[1].to_i

raise('Please provide Day arg as a number between 1-25 inclusive') unless day.between?(1, 25)
raise('Please provide Part arg as a number between 1-2 inclusive') unless part.between?(1, 2)

input = ARGV[2] || 'sample'

path = "#{__dir__}/solutions/#{day}/#{input}"

Instrument.time do
  klass = eval("Day#{day}::Part#{part}", binding, __FILE__, __LINE__) # rubocop:disable Security/Eval
  result = klass.new(path).run
  puts result
  if input =~ /\Asample/ && klass.respond_to?(:expected_result)
    puts "#{klass.expected_result} was expected: #{klass.expected_result == result ? 'OK' : 'WRONG'}"
  end
end
