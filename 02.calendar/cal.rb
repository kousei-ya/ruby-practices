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

if ((options[:year]==today.year || year == {}) && (options[:month]==today.month || month == {}))
  first_day_number.upto(last_day_number) do |x|
    if x == today.mday
      printf("\e[31m%2d\e[0m\s", x);
    else  
      printf("%2d\s",x)
    end
    if (first_day.wday + x) % 7 == 0
      print "\n"
    end
  end
else
  first_day_number.upto(last_day_number) do |x|
    printf("%2d\s",x)
    if (first_day.wday + x) % 7 == 0
      print "\n"
    end
  end
end

2.times{
    print "\n"
}
