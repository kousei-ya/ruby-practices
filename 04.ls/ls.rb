#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  files = Dir.glob('*')
  row = 3
  col = (files.size / row.to_f).ceil
  parts = files.each_slice(col).map do |part|
    part
  end
  print_files(row, col, parts)
end

def print_files(row, col, parts)
  (0..col - 1).each do |i|
    (0..row - 1).each do |j|
      print (parts[j][i]).to_s.ljust(20) if !parts[j].nil?
    end
    puts
  end
end

main
