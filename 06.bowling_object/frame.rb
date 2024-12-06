# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(score)
    shot = Shot.new(score)
    @shots = shot.convert_score
  end

  def convert_shot
    @shots.each_slice(2).map do |converted_to_number|
      converted_to_number[0] == 10 ? [converted_to_number[0]] : converted_to_number
    end
  end
end
