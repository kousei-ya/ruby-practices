# frozen_string_literal: true

class Shot
  def initialize(scores)
    @scores = scores
  end

  def convert_score
    @scores.flat_map do |score|
      score == 'X' ? [10, 0] : score.to_i
    end
  end
end
