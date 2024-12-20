#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'argparser'
require_relative 'standard'
require_relative 'detail'

class Ls
  def initialize
    @opt = ArgumentParser.new
    @options = @opt.parse!(ARGV)
  end

  def main
    sarg = @options[:all] ? File::FNM_DOTMATCH : 0
    @files = Dir.glob('*', sarg)
    @files = @files.reverse if @options[:reverse]
    view_files = if @options[:long].nil?
                   Standard.new(@files)
                 else
                   Detail.new(@files)
                 end
    view_files.print_files
  end
end

ls = Ls.new
ls.main
