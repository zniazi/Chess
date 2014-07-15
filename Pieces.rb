

class Piece
  HORIZONTAL_DELTAS = [[0,1], [0,-1], [-1,0], [1,0]]
  DIAGONAL_DELTAS = [[-1,-1], [-1,1], [1,-1], [1,1]]

  attr_reader :color

  def initialize(color)
    @color = color
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

  def moves
    # moves = KNIGHT_DELTAS.map do |(dx,dy)|
#       [dx += @position[0], dy += @position[1]]
#     end

    KNIGHT_DELTAS
  end

end

class King < SteppingPiece

  def moves
    # [].tap do |horizontals|
#       HORIZONTAL_DELTAS.each do |(dx,dy)|
#         horizontals << [position[0] + dx, position[1] + dy]
#       end
#     end.tap do |diagonals|
#       DIAGONAL_DELTAS.each do |(dx,dy)|
#         diagonals << [position[0] + dx, position[1] + dy]
#       end
#     end
    HORIZONTAL_DELTAS + DIAGONAL_DELTAS
  end

end

class Bishop < SlidingPiece
  def moves
    super(DIAGONAL_DELTAS)
  end
end

class Queen < SlidingPiece
  def moves
    super(DIAGONAL_DELTAS) + super(HORIZONTAL_DELTAS)
  end
end

class Castle < SlidingPiece
  def moves
    super(HORIZONTAL_DELTAS)
  end
end

class Pawn < Piece
  PAWN_DELTAS = [[0, 1], [-1, 1], [1, 1]]

  def moves
    self.color == :B ? PAWN_DELTAS : PAWN_DELTAS.map { |x, y| [x, y * -1] }
  end

end

# Add board.valid_moves(pos)
# moves.select { |(x, y)| [x, y].all? { |coord| (0..7).include?(coord) } }

    # if attack_available?
#       PAWN_DELTAS.map { |(dx, dy)| [position[0] + dx, position[1] + dy] }
#     else
#       dx, dy = PAWN_DELTAS.first[0], PAWN_DELTAS.first[1]
#       [position[0] + dx, position[1] + dy]
#     end





