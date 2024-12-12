# frozen_string_literal: true

require_relative 'standard'
require_relative 'detail'

class Options
  def initialize(options)
    @options = options
  end

  def separate_process
    sarg = @options[:all] ? File::FNM_DOTMATCH : 0
    @files = Dir.glob('*', sarg)
    @files = @files.reverse if @options[:reverse]
    if @options[:long].nil?
      view_files = Standard.new(@files)
      view_files.display_files
    else
      detail_files = Detail.new(@files)
      detail_files.detail_files_print
    end
  end
end
