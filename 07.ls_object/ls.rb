#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'column_file_display'
require_relative 'file_detail_display'

class Ls
  def initialize
    @options = {}
    opt = OptionParser.new
    opt.on('-a', '--all') { |a| @options[:all] = a }
    opt.on('-r', '--reverse') { |r| @options[:reverse] = r }
    opt.on('-l') { |l| @options[:long] = l }
    opt.parse!(ARGV)
  end

  def main
    sarg = @options[:all] ? File::FNM_DOTMATCH : 0
    @files = Dir.glob('*', sarg)
    @files = @files.reverse if @options[:reverse]
    display_class = @options[:long] ? FileDetailDisplay : ColumnFileDisplay
    view_files = display_class.new(@files)
    view_files.show
  end
end

ls = Ls.new
ls.main
