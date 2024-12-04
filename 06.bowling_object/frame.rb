# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(scores)
    @shots = Shot.new(scores)
  end

  def convert_shot
    converted_shots = @shots.convert_score
    converted_shots.each_slice(2).map do |converted_shot|
      converted_shot[0] == 10 ? [converted_shot[0]] : converted_shot
    end
  end
end
