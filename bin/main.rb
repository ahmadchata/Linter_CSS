require_relative '../lib/messages'
require 'colorize'
class StyleRules
	def opening_brace_space(lines, error)
		lines.each_with_index do |line_content, index|
			if line_content.include?('{')
				error.push("On line #{index + 1}: Add a space before the opening brace") if line_content.match(/([a-zA-Z]+|\]|\)){/)
			end
		end
		error
	end

	def indentation_of_block(lines, error)
    lines.each_with_index do |line_content, index|
      if line_content.include?(';')
        error.push("On line #{index + 1}: Indentation of 2 spaces required") unless line_content.match(/^\s{2}[a-zA-Z]/)
      end
    end
    error
	end

	def lower_case_color(lines, error)
		lines.each_with_index do |line_content, index|
			if line_content.include?('#')
				error.push("On line #{index + 1}: Use lower case for hex color code") unless line_content.match(/#[a-z].[a-z];/)
			end
		end
		error
	end

	def empty_block(lines, error)
    lines.each_with_index do |line_content, index|
      error.push("On line #{index + 1}: Block is empty") if line_content.match(/{\n*}/)
    end
    error
	end
	
	def no_unit_for_zero(lines, error)
    lines.each_with_index do |line_content, index|
      if line_content.include?(';')
        error.push("On line #{index + 1}: No unit required if value is Zero") if line_content.match(/[\s](0\w|0%)/)
      end
    end
    error
  end
end

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