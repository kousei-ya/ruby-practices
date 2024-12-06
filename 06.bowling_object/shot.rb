# frozen_string_literal: true

class Shots
  def initialize(score)
    @score = score
  end

  def convert_score
    @score.split(',').flat_map do |converted_score|
      converted_score == 'X' ? [10, 0] : converted_score.to_i
    end
  end
end
