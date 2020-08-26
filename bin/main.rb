class StyleRules
	def opening_brace_space(lines, error)
		lines.each_with_index do |line_content, index|
			if line_content.include?('{')
				error.push("Please add a space before opening brace on line #{index + 1}") if line_content.match(/([a-zA-Z]+|\]|\)){/)
			end
		end
		error
	end