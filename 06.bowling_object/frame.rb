# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(first_shot = nil, second_shot = nil, third_shot = nil)
    @shots = [
      Shot.new(first_shot),
      second_shot ? Shot.new(second_shot) : nil,
      third_shot ? Shot.new(third_shot) : nil
    ].compact
  end

  def score
    @shots.map(&:score)
  end

  def strike?
    score[0] == 10
  end

  def spare?
    score.sum == 10 && score[0] != 10
  end
end
