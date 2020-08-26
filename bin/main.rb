class StyleRules
	def opening_brace_space(lines, error)
		lines.each_with_index do |line_content, index|
			if line_content.include?('{')
				error.push("Add a space before the opening brace on line #{index + 1}") if line_content.match(/([a-zA-Z]+|\]|\)){/)
			end
		end
		error
	end

	def indentation_of_block(lines, error)
    lines.each_with_index do |line_content, index|
      if line_content.include?(';')
        error.push("Indentation of 2 spaces expected on line #{index + 1}") unless line_content.match(/^\s{2}[a-zA-Z]/)
      end
    end
    error
	end

	def lower_case_color(lines, error)
		lines.each_with_index do |line_content, index|
			if line_content.include?('#')
				error.push("Use lower case for hex color code #{index + 1}") if line_content.match(/#[A-Z]/)
			end
		end
		error
	end

	def empty_block(lines, error)
    lines.each_with_index do |line_content, index|
      error.push("Unexpected empty block: #{index + 1}") if line_content.match(/{\n*}/)
    end
    error
	end
	
	def no_unit_for_zero(lines, error)
    lines.each_with_index do |line_content, index|
      if line_content.include?(';')
        error.push("No unit required if value is Zero on line: #{index + 1}") if line_content.match(/[\s](0\w|0%)/)
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
  puts 'no errors found'
else
  errors.each { |error| puts error }
end