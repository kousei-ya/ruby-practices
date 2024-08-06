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

first_day_number = first_day.mday
last_day_number = last_day.mday

if ((year==today.year) && (month==today.month))
  (first_day..last_day).each do |date|
    if date == today
      printf("\e[7m%2d\e[0m\s", date.mday);
    else  
      printf("%2d\s",date.mday)
    end
    if date.saturday?
      print "\n"
    end
  end
else
  (first_day..last_day).each do |date|
    printf("%2d\s",date.mday)
      if date.saturday?
      print "\n"
    end
  end
end

2.times{
    print "\n"
}
