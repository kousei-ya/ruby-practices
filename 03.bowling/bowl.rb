#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = scores.flat_map do |s|
  s == 'X' ? [10, 0] : s.to_i
end

frames = []
frames = shots.each_slice(2).map do |s|
  s[0] == 10 ? [s[0]] : s
end

point = frames.each_with_index.sum do |current_frame, i|
  next_frame = frames[i + 1]
  next_next_fram = frames[i + 2]
  if i < 9
    if current_frame[0] == 10
      if (next_frame[0] == 10) && !next_next_fram.nil?
        10 + next_frame[0] + next_next_fram[0]
      else
        10 + next_frame[0] + next_frame[1]
      end
    elsif (current_frame[0] + current_frame[1] == 10) && !next_frame.nil?
      10 + next_frame[0]
    else
      current_frame[0] + current_frame[1]
    end
  else
    current_frame.sum
  end
end

puts point
