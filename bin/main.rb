require_relative '../lib/messages'
require_relative '../lib/style_rules'
require_relative '../lib/style'
require 'colorize'

file = File.open(ARGV[0]).to_a
errors = Style.check(file)

if errors.empty?
	print Messages::DONE
  print Messages::NO_ERRORS
else
	print Messages::DONE
	puts "#{errors.length} errors".red
  errors.each { |error| puts "#{error}".red }
end