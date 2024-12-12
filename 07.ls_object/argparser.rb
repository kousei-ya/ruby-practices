# frozen_string_literal: true

require 'optparse'

class ArgumentParser
  def initialize
    @options = {}
    @opt = OptionParser.new
    @opt.on('-a', '--all') { |a| @options[:all] = a }
    @opt.on('-r', '--reverse') { |r| @options[:reverse] = r }
    @opt.on('-l') { |l| @options[:long] = l }
  end

  def parse!(args)
    @opt.parse!(args)
    @options
  end
end
