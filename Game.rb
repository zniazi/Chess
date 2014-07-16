require './Board.rb'

class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end

class LeftInCheckError < StandardError
end

class Game

  attr_reader :player1, :player2, :board

  def initialize
    @board = Board.new
    @player1 = Player.new(:W, @board)
    @player2 = Player.new(:B, @board)
    @player1 = player1
    @player2 = player2
  end

  def play
    until game_over?
      board.render
      from, to = player1.get_move
      board.make_move(from, to)
      puts "Player 2 you are in check" if board.in_check?(player2.color)
      board.render
      from, to = player2.get_move
      board.make_move(from, to)
      puts "Player 1 you are in check" if board.in_check?(player1.color)
    end

    puts "Game over"
  end

  def game_over?
    board.checkmate?(:W) || board.checkmate?(:B)
  end

end

class Player

  attr_reader :color, :board
  def initialize(color, board)
    @color = color
    @board = board
  end

  def get_move
    letters = ("A".."H").to_a
    numbers = ("0".."7").to_a

    begin
      puts "Please enter starting position (i.e A5)"
      letter, number = gets.chomp.split("")
      from_x, from_y = letters.index(letter), numbers.index(number)
      raise ArgumentError if !letters.include?(letter) || !numbers.include?(number)
      raise NoPieceError if @board[[from_x,from_y]].nil? || @board[[from_x,from_y]].color != color
    rescue ArgumentError
      puts "Please enter a valid position"
      retry
    rescue NoPieceError
      puts "You can't move from there"
      retry
    end

    valid_moves = @board.valid_moves([from_x, from_y]).map {|(x,y)| "#{letters[x]}#{y}"}

    begin
      puts "Please enter move position Possible positions are #{valid_moves}"
      letter, number = gets.chomp.split("")
      to_x, to_y = letters.index(letter), numbers.index(number)
      raise InvalidMoveError unless valid_moves.include?("#{letter}#{number}")
      raise LeftInCheckError if @board.left_in_check?([from_x, from_y], [to_x, to_y])
    rescue InvalidMoveError
      puts "Invalid move!"
      retry
    rescue LeftInCheckError
      puts "You're exposing your King."
      get_move
      retry
    end

    [[from_x, from_y], [to_x, to_y]]
  end
end
#
# load 'Pieces.rb'
# load 'Board.rb'
# load 'Game.rb'
# Game.new.play



