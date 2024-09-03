#!/usr/bin/env ruby
# frozen_string_literal: true
ARRANGE = 20

def main
  files = Dir.glob('*')
  column = 3
  row = files.size.ceildiv(column)
  parts_files = files.each_slice(row).to_a

  max_size = parts_files.max_by{|order| order.size}.size
  arrange_array = parts_files.each do |order|
    while order.size < max_size
      order << nil
    end
  end
  transpose_array = arrange_array.transpose  
  print_files(transpose_array)
end

def print_files(transpose_array)
  transpose_array.each do |column|
    column.each do |row|
      print row.to_s.ljust(ARRANGE) 
    end
    puts
  end
end

main
