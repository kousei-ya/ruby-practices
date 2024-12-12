#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'argparser'
require_relative 'options'

class Ls
  def initialize
    @opt = ArgumentParser.new
    @options = @opt.parse!(ARGV)
  end

  def main
    option = Options.new(@options)
    option.separate_process
  end
end

ls = Ls.new
ls.main
