#! /usr/bin/env ruby

require "optparse"
require "date"

options = {}

opt = OptionParser.new
opt.on("-y VALUE", Integer) {|y| options[:year] = y}
opt.on("-m VALUE", Integer) {|m| options[:month] = m }
opt.parse!(ARGV)

today = Date.today

if options[:year] != nil
  year = options[:year]
else
  year = today.year
end

if options[:month] != nil
  month = options[:month]
else
  month = today.month
end

first_day = Date.new(year,month)
last_day = Date.new(year,month,-1)

puts "      #{first_day.mon}月 #{first_day.year}"

puts "日 月 火 水 木 金 土"

first_day.wday.times{print "\s\s\s"}

(first_day..last_day).each do |date|
  print ("\e[7m#{date.mday}") if date == today
  print("\e[0m") if date == today
  print "#{date.mday}".rjust(2) if date != today
  print("\s")
  puts if date.saturday?
end

puts
