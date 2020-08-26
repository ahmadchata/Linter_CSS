require_relative '../lib/messages'
require_relative '../lib/style_rules'
require 'colorize'

class Style
	def Style.check(file)
		errors = []
		lines = file
		if !file.empty?
			check = StyleRules.new
			check.empty_block(lines, errors)
			check.opening_brace_space(lines, errors)
			check.indentation_of_block(lines, errors)
			check.lower_case_color(lines, errors)
			check.no_unit_for_zero(lines, errors)
		end
		errors
	end
end

file = File.open(ARGV[0]).to_a
errors = Style.check(file)

if errors.empty?
	puts Messages::DONE
	puts Messages::LINE
  puts Messages::NO_ERRORS
else
	puts Messages::DONE
	puts Messages::LINE
  errors.each { |error| puts error.red }
end