require_relative '../lib/messages'
require_relative '../lib/style_rules'
require_relative '../lib/style'
require 'colorize'



file = File.open(ARGV[0]).to_a
errors = Style.check(file)

if errors.empty?
	puts Messages::DONE
  puts Messages::NO_ERRORS
else
	puts Messages::DONE
  errors.each { |error| puts "#{errors.length} found"}
end