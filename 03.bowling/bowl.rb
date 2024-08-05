#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << if s[0] == 10
              [s[0]]
            else
              s
            end
end

point = 0

(0..frames.size - 1).each do |i|
  point += if i < 9 # 9フレームまでの処理
             if (frames[i][0] == 10) && !frames[i + 1].nil? # ストライク
               if (frames[i + 1][0] == 10) && !frames[i + 2].nil? # 次もストライク
                 10 + frames[i + 1][0] + frames[i + 2][0]
               else
                 10 + frames[i + 1][0] + frames[i + 1][1] # ストライク(次がストライクでない)
               end
             elsif (frames[i][0] + frames[i][1] == 10) && !frames[i + 1].nil? # スペア
               10 + frames[i + 1][0]
             else
               frames[i][0] + frames[i][1]
             end
           elsif !frames[i][1].nil?
             frames[i][0] + frames[i][1]
           else
             frames[i][0]
           end
end

puts point
