#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

WIDTH = 5

def main
  options = {}
  opt = OptionParser.new
  opt.on('-l', '--lines') { |l| options[:lines] = l }
  opt.on('-w', '--words') { |w| options[:words] = w }
  opt.on('-c', '--bytes') { |c| options[:bytes] = c }
  opt.parse!(ARGV)
  files = ARGV
  pipe_branch(options, files)
end

def pipe_branch(options, files)
  if files.empty?
    str = $stdin.read
    print_files(str, options)
    puts
  else
    files.each do |arg|
      str = File.read("./#{arg}")
      print_files(str, options)
      print arg
      puts
    end
    return unless files.size >= 2

    print_total(files, options)
  end
end

def print_files(str, options)
  print "#{str.lines.count}\s".rjust(WIDTH) if line_option_enabled?(options)
  print "#{str.split.size}\s".rjust(WIDTH) if word_option_enabled?(options)
  print "#{str.size}\s".rjust(WIDTH) if byte_option_enabled?(options)
end

def print_total(files, options)
  print "#{files.sum { |line| File.read("./#{line}").lines.count }}\s".rjust(WIDTH) if line_option_enabled?(options)
  print "#{files.sum { |word| File.read("./#{word}").split.size }}\s".rjust(WIDTH) if word_option_enabled?(options)
  print "#{files.sum { |byte| File.read("./#{byte}").size }}\s".rjust(WIDTH) if byte_option_enabled?(options)
  print 'total'
  puts
end

def line_option_enabled?(options)
  options[:lines] || options.empty?
end

def word_option_enabled?(options)
  options[:words] || options.empty?
end

def byte_option_enabled?(options)
  options[:bytes] || options.empty?
end

main
