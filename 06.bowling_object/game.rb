# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :converted_shots

  def initialize(score)
    scores = score.split(',')
    @frames = Frame.new(scores)
  end

  def execute
    devided_two_shot = @frames.convert_shot
    calculation(devided_two_shot)
  end

  def calculation(devided_two_shot)
    devided_two_shot.each_with_index.sum do |current_frame, i|
      next_frame = devided_two_shot[i + 1]
      after_next_frame = devided_two_shot[i + 2]
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
puts game.execute
