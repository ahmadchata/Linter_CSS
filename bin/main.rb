#!/usr/bin/env ruby

require_relative '../lib/messages'
require_relative '../lib/style_rules'
require_relative '../lib/style'
require 'colorize'

file = File.open(ARGV[0]).to_a
errors = Style.check(file)

print Messages::DONE
if errors.empty?
  print Messages::NO_ERRORS
elsif errors.length == 1
  puts "#{errors.length} error".red
else
  puts "#{errors.length} errors".red
  errors.each { |error| puts error.red }
end
