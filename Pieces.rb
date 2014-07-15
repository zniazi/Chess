# coding: utf-8

class Piece
  HORIZONTAL_DELTAS = [[0,1], [0,-1], [-1,0], [1,0]]
  DIAGONAL_DELTAS = [[-1,-1], [-1,1], [1,-1], [1,1]]

  attr_reader :color, :graphic

  def initialize(color)
    @color = color
    @graphic = " "
  end

  def moves
    #abstract method
  end
end

class SteppingPiece < Piece
end

class SlidingPiece < Piece
  def moves(delta_constants)
    moves = []

    delta_constants.each do |(dx, dy)|
      1.upto(8) do |inc|
        move = [inc * dx, inc * dy]
        moves << move
      end
    end

    moves
  end
end

class Knight < SteppingPiece
  KNIGHT_DELTAS = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

  def initialize(color)
    super(color)
    @graphic = (color == :W) ? "♘" : "♞"
  end

  def moves
    KNIGHT_DELTAS
  end

end

class King < SteppingPiece

  def initialize(color)
    super(color)
    @graphic = (color == :W) ? "♔" : "♚"
  end

  def moves
    HORIZONTAL_DELTAS + DIAGONAL_DELTAS
  end

end

class Bishop < SlidingPiece

  def initialize(color)
    super(color)
    @graphic = (color == :W) ? "♗" : "♝"
  end

  def moves
    super(DIAGONAL_DELTAS)
  end
end

class Queen < SlidingPiece

  def initialize(color)
    super(color)
    @graphic = (color == :W) ? "♕" : "♛"
  end

  def moves
    super(DIAGONAL_DELTAS) + super(HORIZONTAL_DELTAS)
  end
end

class Castle < SlidingPiece
  attr_reader :graphic

  def initialize(color)
    super(color)
    @graphic = (color == :W) ? "♖" : "♜"
  end

  def moves
    super(HORIZONTAL_DELTAS)
  end
end

class Pawn < Piece
  PAWN_DELTAS = [[0, 1], [-1, 1], [1, 1]]

  def initialize(color)
    super(color)
    @graphic = (color == :W) ? "♙" : "♟"
  end

  def moves
    self.color == :B ? PAWN_DELTAS : PAWN_DELTAS.map { |x, y| [x, y * -1] }
  end

end





