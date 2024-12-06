# frozen_string_literal: true

require_relative 'game'

describe Game do
  example 'パーフェクト' do
    game = described_class.new('X,X,X,X,X,X,X,X,X,X,X,X')
    expect(game.calculation).to eq 300
  end

  example 'ゼロ' do
    game = described_class.new('0,0,0,0,0,0,0,0,0,0,0')
    expect(game.calculation).to eq 0
  end

  example do
    game = described_class.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    expect(game.calculation).to eq 139
  end

  example do
    game = described_class.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    expect(game.calculation).to eq 164
  end

  example do
    game = described_class.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    expect(game.calculation).to eq 107
  end

  example do
    game = described_class.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    expect(game.calculation).to eq 134
  end

  example do
    game = described_class.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
    expect(game.calculation).to eq 144
  end

  example do
    game = described_class.new('X,X,X,X,X,X,X,X,X,X,X,2')
    expect(game.calculation).to eq 292
  end

  example do
    game = described_class.new('X,0,0,X,0,0,X,0,0,X,0,0,X,0,0 ')
    expect(game.calculation).to eq 50
  end
end
