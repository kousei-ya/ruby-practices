#!/usr/bin/env ruby
# frozen_string_literal: true
ARRANGE = 20

def main
  files = Dir.glob('*')
  column = 3
  row = files.size.ceildiv(column)
  parts_files = files.each_slice(row).to_a.transpose
  print_files(parts_files)
end

def print_files(parts_files)
arrange = 20
  parts_files.each do |column|
    column.each do |row|
      print row.to_s.ljust(ARRANGE) 
    end
    puts
  end
end

main
