class Piece
end

class SteppingPiece < Piece
end

class SlidingPiece < Piece
end

class Knight < SteppingPiece
end

class King < SteppingPiece
end

class Bishop < SlidingPiece
end

class Queen < SlidingPiece
end

class Castle < SlidingPiece
end