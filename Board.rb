require "./Pieces.rb"

class Board

  def self.place_pieces
    blacks = [Castle.new(:B), Knight.new(:B), Bishop.new(:B), Queen.new(:B),
      King.new(:B), Bishop.new(:B), Knight.new(:B), Castle.new(:B)]
    whites = [Castle.new(:W), Knight.new(:W), Bishop.new(:W), King.new(:B),
      Queen.new(:W), Bishop.new(:W), Knight.new(:W), Castle.new(:W)]

    black_pawns = Array.new(8) { Pawn.new(:B) }
    white_pawns = Array.new(8) { Pawn.new(:W) }

    board = Array.new(8) { Array.new(8) }

    board[0] = blacks
    board[1] = black_pawns
    board[6] = white_pawns
    board[7] = whites

    board
  end

  attr_accessor :board

  def initialize
    @board = Board.place_pieces
  end

  def same_color(start_pos, move_pos)
    self[start_pos].color == self[move_pos].color
  end

  def valid_position?(start_pos, move_pos)
    move_pos.all? { |coord| (0..7).include?(coord) } && !same_color(start_pos, move_pos)
  end

  def valid_moves(start_position)
    piece = @board[start_position]
    piece.moves.select { |new_position| valid_position?(start_position, new_position) }
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    board[x][y] = mark
  end

end


