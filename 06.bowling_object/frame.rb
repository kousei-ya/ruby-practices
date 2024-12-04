# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(scores)
    @shots = Shot.new(scores)
  end

  def convert_shot
    converted_to_numbers = @shots.convert_score
    converted_to_numbers.each_slice(2).map do |converted_to_number|
      converted_to_number[0] == 10 ? [converted_to_number[0]] : converted_to_number
    end
  end
end
