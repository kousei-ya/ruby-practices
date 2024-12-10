# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(score)
    scores = score.split(',')
    @frames = []
    9.times do
      first_shot = scores.shift
      if first_shot == 'X'
        @frames << Frame.new(first_shot)
      else
        second_shot = scores.shift
        @frames << Frame.new(first_shot, second_shot)
      end
    end
    @frames << Frame.new(*scores.compact)
  end

  def calculate
    @frames.each_with_index.sum do |frame, i|
      next_frame = @frames[i + 1]
      after_next_frame = @frames[i + 2]
      base_score = frame.score.sum
      base_score + bonus_score(frame, next_frame, after_next_frame, i)
    end
  end

  private

  def bonus_score(frame, next_frame, after_next_frame, index)
    return 0 if index >= 9

    if frame.strike?
      strike_bonus(next_frame, after_next_frame)
    elsif frame.spare?
      spare_bonus(next_frame)
    else
      0
    end
  end

  def strike_bonus(next_frame, after_next_frame)
    return 0 unless next_frame

    next_two_shots = next_frame.score + (after_next_frame&.score || [])
    next_two_shots.take(2).sum
  end

  def spare_bonus(next_frame)
    return 0 unless next_frame

    next_frame.score[0]
  end
end

if ARGV[0].nil? || ARGV[0].empty?
  puts 'スコアを指定してください。'
  exit
end

game = Game.new(ARGV[0])
puts game.calculate
