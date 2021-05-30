class StyleRules
  def opening_brace_space(lines, error)
    lines.each_with_index do |line_content, index|
      next unless line_content.include?('{')

      if line_content.match(/([a-zA-Z]+|\]|\)){/)
        error.push("On line #{index + 1}: Add a space before the opening brace")
      end
    end
    error
  end

  def indentation_of_block(lines, error)
    lines.each_with_index do |line_content, index|
      next unless line_content.include?(';')

      error.push("On line #{index + 1}: Indentation of 2 spaces required") unless line_content.match(/^\s{2}[a-zA-Z]/)
    end
    error
  end

  def lower_case_color(lines, error)
    lines.each_with_index do |line_content, index|
      next unless line_content.include?('#')

      error.push("On line #{index + 1}: Use lower case for hex color code") unless line_content.match(/"^#[a-z0-9_\-]+$"/)
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
