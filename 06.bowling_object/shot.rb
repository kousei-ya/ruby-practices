# frozen_string_literal: true

class Shot
  def initialize(score)
    @score = score.split(',')
  end

  def convert_score
    @score.flat_map do |score|
      score == 'X' ? [10, 0] : score.to_i
    end
  end
end
