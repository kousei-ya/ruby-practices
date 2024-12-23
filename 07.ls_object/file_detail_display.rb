# frozen_string_literal: true

require 'etc'

class FileDetailDisplay
  def initialize(files)
    @files = files
  end

  def show
    puts "total #{total_count(@files)}"
    @files.each do |file|
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

  private

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

  def print_attributes(attributes)
    attributes.each { |attribute| print "#{attribute} " }
  end

  def print_name(file_info)
    print_attributes([
                       Etc.getpwuid(file_info.uid).name,
                       Etc.getgrgid(file_info.gid).name
                     ])
  end

  def last_updated_time(file_info)
    formats = ['%b', '%e', '%H:%M']
    attributes = formats.map { |format| file_info.mtime.strftime(format) }
    print_attributes(attributes)
  end
end
