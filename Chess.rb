class Piece
  HORIZONTAL_DELTAS = [[0,1], [0,-1], [-1,0], [1,0]]
  DIAGONAL_DELTAS = [[-1,-1], [-1,1], [1,-1], [1,1]]

  attr_accessor :position

  def initialize
    @position = [4,4]
  end

  def moves
    #abstract method
  end
end

class SteppingPiece < Piece
end

class SlidingPiece < Piece
end

class Knight < SteppingPiece
  KNIGHT_DELTAS = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

  def moves
    moves = KNIGHT_DELTAS.map do |(dx,dy)|
      [dx += @position[0], dy += @position[1]]
    end

    moves
  end

end

class King < SteppingPiece

  def moves
    [].tap do |horizontals|
      HORIZONTAL_DELTAS.each do |(dx,dy)|
        horizontals << [position[0] + dx, position[1] + dy]
      end
    end.tap do |diagonals|
      DIAGONAL_DELTAS.each do |(dx,dy)|
        diagonals << [position[0] + dx, position[1] + dy]
      end
    end

  end

end

class Bishop < SlidingPiece
  def moves
    moves = []
    DIAGONAL_DELTAS.each do |(dx, dy)|
      1.upto(8) do |inc|
        moves << [inc * dx + position[0], inc * dy + position[1]]
      end
    end

    moves.select { |(x, y)| [x, y].all? { |coord| (0..7).include?(coord) } }
  end
end

class Queen < SlidingPiece
end

class Castle < SlidingPiece
end