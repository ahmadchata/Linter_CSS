require 'colorize'
require_relative '../lib/style_rules'
require_relative '../lib/style'


module Messages
  DONE = "Linter has finished checking your file and found ".bold
  NO_ERRORS = "No errors".green.bold
end