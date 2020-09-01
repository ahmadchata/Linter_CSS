require_relative '../lib/style_rules'

class Style
  def self.check(file)
    errors = []
    lines = file
    unless file.empty?
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
