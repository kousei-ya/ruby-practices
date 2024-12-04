# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :converted_shots

  def initialize(score)
    scores = score.split(',')
    @frames = Frame.new(scores)
  end

  def execute
    converted_frames = @frames.convert_shot
    calculation(converted_frames) #テストの際に使用
    #puts calculation(converted_frames) # テストの際はコメントアウト
  end

  def calculation(converted_frames)
    converted_frames.each_with_index.sum do |current_frame, i|
      next_frame = converted_frames[i + 1]
      after_next_frame = converted_frames[i + 2]
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
game.execute
