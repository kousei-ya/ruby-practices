# frozen_string_literal: true

require_relative 'shot'

class Frames
  def initialize(score)
    score = Shots.new(score)
    @shots = score.convert_score
  end

  def convert_shots
    @shots.each_slice(2).map do |converted_shot|
      converted_shot[0] == 10 ? [converted_shot[0]] : converted_shot
    end
  end
end
