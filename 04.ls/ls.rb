#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'
require 'etc'

ARRANGE = 20

def main
  options = {}
  opt = OptionParser.new
  opt.on('-a', '--all') { |a| options[:all] = a }
  opt.on('-r', '--reverse') { |r| options[:reverse] = r }
  opt.on('-l') { |l| options[:long] = l }
  opt.parse!(ARGV)

  sarg = options[:all] ? File::FNM_DOTMATCH : 0
  files = Dir.glob('*', sarg)
  files = files.reverse if options[:reverse]
  detail_files(files) if options[:long]

  column = 3
  row = files.size.ceildiv(column)
  parts_files = files.each_slice(row).to_a

  max_size = parts_files.max_by(&:size).size
  arrange_array = parts_files.each do |order|
    order << nil while order.size < max_size
  end
  transpose_array = arrange_array.transpose
  print_files(transpose_array) unless options[:long]
end

def detail_files(files)
  puts "total #{total_count(files)}"
  files.each do |file|
    file_info = File.stat(file)
    file_access_info = file_info.mode.to_s(8)
    print file_info.ftype == 'file' ? '-' : 'd'
    file_access_info.prepend('0') if file_access_info.size == 5
    file_access_info_print(file_access_info)
    print "\s#{file_info.nlink}\s"
    print "#{Etc.getpwuid(file_info.uid).name}\s"
    print "#{Etc.getgrgid(file_info.gid).name}\s"
    print "#{file_info.size}\s".rjust(5)
    print "#{file_info.mtime.strftime('%b')}\s"
    print "#{file_info.mtime.strftime('%e')}\s"
    print "#{file_info.mtime.strftime('%H:%M')}\s"
    print file
    puts
  end
end

def total_count(files)
  total = 0
  files.each do |file|
    file_info = File.stat(file)
    total += file_info.blocks / 2
  end
  total
end

def file_access_info_print(file_access_info)
  3.times do |i|
    case file_access_info[3 + i]
    when '0'
      print '---'
    when '1'
      print '--x'
    when '2'
      print '-w-'
    when '3'
      print '-wx'
    when '4'
      print 'r--'
    when '5'
      print 'r-x'
    when '6'
      print 'rw-'
    when '7'
      print 'rwx'
    end
  end
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
