require 'colorize'
require_relative '../lib/style_rules'
require_relative '../lib/style'
require_relative 'main.rb'

module Messages
  DONE = "Linter has finished checking your file and #{errors.length} found".bold
  NO_ERRORS = 'No errors'.green.bold
end