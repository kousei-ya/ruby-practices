# frozen_string_literal: true

ARRANGE = 20

class Standard
  def initialize(files, column = 3)
    @files = files
    @column = column
  end

  def print_files
    transpose_array = divide_files(@files)
    transpose_array.each do |column|
      column.each do |row|
        print row.to_s.ljust(ARRANGE)
      end
      puts
    end
  end

  private

  def divide_files(files)
    row = files.size.ceildiv(@column)
    parts_files = files.each_slice(row).to_a

    max_size = parts_files.max_by(&:size).size
    arrange_array = parts_files.each do |order|
      order << nil while order.size < max_size
    end
    arrange_array.transpose
  end
end
