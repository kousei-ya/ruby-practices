#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

ARRANGE = 20

def main
  options = {}
  opt = OptionParser.new
  opt.on('-a', '--all') { |a| options[:all] = a }
  opt.on('-r', '--reverse') { |r| options[:reverse] = r }
  opt.parse!(ARGV)

  sarg = options[:all] ? File::FNM_DOTMATCH : 0
  files = Dir.glob('*', sarg)
  files = files.reverse if options[:reverse]
  column = 3
  row = files.size.ceildiv(column)
  parts_files = files.each_slice(row).to_a

  max_size = parts_files.max_by(&:size).size
  arrange_array = parts_files.each do |order|
    order << nil while order.size < max_size
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
