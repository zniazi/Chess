require 'Board.rb'

class Game

  attr_reader :player1, :player2, :board

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end

  def play
    until game_over?
      board.render
      player1.move
      board.render
      player2.move
    end
  end

  def game_over?
    board.checkmate? # Need to write checkmate method
  end

end