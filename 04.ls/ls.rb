#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  files = Dir.glob('*')
  column = 3
  row = files.size.ceildiv(column)
  parts_files = files.each_slice(row).to_a
  print_files(parts_files)
end

def print_files(parts_files)
arrange = 20
  parts_files.each_with_index do |row,i|
    parts_files.each_with_index do |column,j|
      print (parts_files[j][i]).to_s.ljust(arrange) unless parts_files[j].nil?
    end
    puts
  end
end

main
