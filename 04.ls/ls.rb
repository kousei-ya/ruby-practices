#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
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
  if options[:long].nil?
    divide_files(files)
  else
    detail_files(files)
  end
end

def divide_files(files)
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

def detail_files(files)
  puts "total #{total_count(files)}"
  files.each do |file|
    file_info = File.stat(file)
    file_access_info = (file_info.mode & 0o777).to_s(8).split('')
    print file_info.ftype == 'file' ? '-' : 'd'
    change_file_access = file_access_info.map { |part| access_print_change(part) }.join
    print change_file_access
    print "\s#{file_info.nlink}\s"
    print_name(file_info)
    print "#{file_info.size}\s".rjust(5)
    last_updated_time(file_info)
    print file
    puts
  end
end

def total_count(files)
  files.sum { |file| File.stat(file).blocks / 2 }
end

def access_print_change(part)
  { '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx' }[part]
end

def print_name(file_info)
  print "#{Etc.getpwuid(file_info.uid).name}\s"
  print "#{Etc.getgrgid(file_info.gid).name}\s"
end

def last_updated_time(file_info)
  print "#{file_info.mtime.strftime('%b')}\s"
  print "#{file_info.mtime.strftime('%e')}\s"
  print "#{file_info.mtime.strftime('%H:%M')}\s"
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
