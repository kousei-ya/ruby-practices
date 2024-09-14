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
  print "#{str.lines.count}\s".rjust(WIDTH) if do_options_lines(options).is_a?(TrueClass)
  print "#{str.split.size}\s".rjust(WIDTH) if do_options_words(options).is_a?(TrueClass)
  print "#{str.size}\s".rjust(WIDTH) if do_options_bytes(options).is_a?(TrueClass)
end

def print_total(files, options)
  print "#{files.sum { |line| File.read("./#{line}").lines.count }}\s".rjust(WIDTH) if do_options_lines(options).is_a?(TrueClass)
  print "#{files.sum { |word| File.read("./#{word}").split.size }}\s".rjust(WIDTH) if do_options_words(options).is_a?(TrueClass)
  print "#{files.sum { |byte| File.read("./#{byte}").size }}\s".rjust(WIDTH) if do_options_bytes(options).is_a?(TrueClass)
  print 'total'
  puts
end

def do_options_lines(options)
  true if options[:lines] || options.empty?
end

def do_options_words(options)
  true if options[:words] || options.empty?
end

def do_options_bytes(options)
  true if options[:bytes] || options.empty?
end

main
