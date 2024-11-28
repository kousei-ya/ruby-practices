# frozen_string_literal: true

class Frame
  def initialize(converted_shots)
    @converted_shots = converted_shots
  end

  def convert_shot
    @converted_shots.each_slice(2).map do |converted_shot|
      converted_shot[0] == 10 ? [converted_shot[0]] : converted_shot
    end
  end
end
