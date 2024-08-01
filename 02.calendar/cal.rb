#! /usr/bin/env ruby

require "optparse"
require "date"

year = {}
month = {}

opt = OptionParser.new
opt.on("-y VALUE", Integer) {|y| year[:a] = y}
opt.on("-m VALUE", Integer) {|m| month[:b] = m }
opt.parse!(ARGV)

#引数を指定しない場合と指定する場合の月初と月末を取得
if year == {}
  if month == {}
    first_day = Date.new(Date.today.year,Date.today.month)
    last_day =  Date.new(Date.today.year,Date.today.month,-1)
  else
    first_day = Date.new(Date.today.year,month[:b])
    last_day =  Date.new(Date.today.year,month[:b],-1)
  end
else
  first_day = Date.new(year[:a],month[:b])
  last_day = Date.new(year[:a],month[:b],-1)
end

#月と年を表示
puts "      #{first_day.mon}月 #{first_day.year}"

puts "日 月 火 水 木 金 土"

#月初の曜日の分だけ空白を入れる
first_day.wday.times{print "\s\s\s"}

first_day_number = first_day.mday
last_day_number = last_day.mday

#月初から月末までの値を表示（土曜日に改行、今日の色を変更）
if ((year[:a]==Date.today.year || year == {}) && (month[:b]==Date.today.month || month == {}))
  first_day_number.upto(last_day_number) do |x|
    if x == Date.today.mday
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