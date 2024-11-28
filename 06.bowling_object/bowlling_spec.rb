# frozen_string_literal: true

require_relative 'game'

describe Game do
  example 'パーフェクト' do
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    expect(game.execution).to eq 300
  end

  example 'ゼロ' do
    game = Game.new('0,0,0,0,0,0,0,0,0,0,0')
    expect(game.execution).to eq 0
  end

  example '普通１' do
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    expect(game.execution).to eq 139
  end

  example '普通２' do
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    expect(game.execution).to eq 164
  end

  example '普通３' do
    game = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    expect(game.execution).to eq 107
  end
end

describe 'Game' do
  example '普通４' do
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    expect(game.execution).to eq 134
  end

  example '普通５' do
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
    expect(game.execution).to eq 144
  end

  example '普通６' do
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,2')
    expect(game.execution).to eq 292
  end

  example '普通７' do
    game = Game.new('X,0,0,X,0,0,X,0,0,X,0,0,X,0,0 ')
    expect(game.execution).to eq 50
  end
end
