require_relative 'board'
require_relative 'player'
require 'byebug'

class Game
  def initialize(board=Board.new, player=Player.new)
    @board = board
    @player = player
  end

  #if tile is explored, show it forever, else show "| |""
  def render

  end

  #get prompt from player
  def get_turn
    @pos, @action = @player.prompt
  end

  #all tile are either explored or flagged for bombs
  def won?
  end

  #any bomb is explored
  def lose?
  end

end
