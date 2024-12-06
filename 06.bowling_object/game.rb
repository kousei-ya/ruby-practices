# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(score)
    score = Frames.new(score)
    @frames = score.convert_shots
  end

  def calculate
    @frames.each_with_index.sum do |current_frame, i|
      next_frame = @frames[i + 1]
      after_next_frame = @frames[i + 2]
      if i < 9
        if current_frame[0] == 10
          10 + [*next_frame, *after_next_frame].take(2).sum
        elsif current_frame.sum == 10
          10 + next_frame[0]
        else
          current_frame.sum
        end
      else
        current_frame.sum
      end
    end
  end
end

if ARGV[0].nil? || ARGV[0].empty?
  puts 'スコアを指定してください。'
  exit
end

game = Game.new(ARGV[0])
puts game.calculate
