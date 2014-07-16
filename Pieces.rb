# coding: utf-8

class Piece
  HORIZONTAL_DELTAS = [[0,1], [0,-1], [-1,0], [1,0]]
  DIAGONAL_DELTAS = [[-1,-1], [-1,1], [1,-1], [1,1]]

  attr_reader :color, :graphic
  attr_accessor :position

  def initialize(color, position)
    @color = color
    @graphic = ""
    @position = position
  end

  def moves
  end
end

class SteppingPiece < Piece
  def moves(delta_constants)
    x, y = position
      delta_constants.map { |(dx, dy)| [x + dx, y + dy] }
  end
end

class SlidingPiece < Piece
  def moves(delta_constant)
    paths = []
    x, y = position

    delta_constant.each do |(dx, dy)|
      path = []
      1.upto(8) do |inc|
        move = [inc * dx + x, inc * dy + y]
        path << move
      end

      paths << path
    end

    paths
  end
end

class Knight < SteppingPiece
  KNIGHT_DELTAS = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

  def initialize(color, position)
    super(color, position)
    @graphic = (color == :W) ? "♘" : "♞"
  end

  def moves
    super(KNIGHT_DELTAS)
  end

end

class King < SteppingPiece

  def initialize(color, position)
    super(color, position)
    @graphic = (color == :W) ? "♔" : "♚"
  end

  def moves
    super(HORIZONTAL_DELTAS) + super(DIAGONAL_DELTAS)
  end

end

class Bishop < SlidingPiece

  def initialize(color, position)
    super(color, position)
    @graphic = (color == :W) ? "♗" : "♝"
  end

  def moves
    super(DIAGONAL_DELTAS)
  end
end

class Queen < SlidingPiece

  def initialize(color, position)
    super(color, position)
    @graphic = (color == :W) ? "♕" : "♛"
  end

  def moves
    super(DIAGONAL_DELTAS) + super(HORIZONTAL_DELTAS)
  end
end

class Castle < SlidingPiece
  attr_reader :graphic

  def initialize(color, position)
    super(color, position)
    @graphic = (color == :W) ? "♖" : "♜"
  end

  def moves
    super(HORIZONTAL_DELTAS)
  end
end

class Pawn < Piece
  PAWN_DELTAS = [[0, 1], [-1, 1], [1, 1]]

  attr_reader :initial_position
  attr_accessor :first_move
  def initialize(color, position)
    super(color, position)
    @graphic = (color == :W) ? "♙" : "♟"
    @first_move = true
  end

  def moves
    x, y = position
    self.color == :B ? multiplier = 1 : multiplier = -1

    if self.first_move
      pawn_deltas = PAWN_DELTAS + [[0,2]]
      pawn_moves = pawn_deltas.map { |dx, dy| [x + dx, y + (multiplier * dy)] }
    else
      pawn_moves = PAWN_DELTAS.map { |dx, dy| [x + dx, y + (multiplier * dy)] }
    end

    pawn_moves
  end

end




