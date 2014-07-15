class Piece
  attr_accessor :position

  def initialize
    @position = [2,4]
  end

  def moves
    #abstract method
  end
end

class SteppingPiece < Piece
end

class SlidingPiece < Piece
  HORIZONTAL_DELTAS = [[0,1], [0,-1], [-1,0], [1,0]]
  DIAGONAL_DELTAS = [[-1,-1], [-1,1], [1,-1], [1,1]]
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
end

class Bishop < SlidingPiece
  def moves
    moves = []
    DIAGONAL_DELTAS.each do |delta|
      8.times { |inc| moves << [inc * delta[0], inc * delta[1]] }
    end

    moves.select { |(x, y)| [x, y].all? { |coord| (0..7).include?(coord) } }
  end
end

class Queen < SlidingPiece
end

class Castle < SlidingPiece
end