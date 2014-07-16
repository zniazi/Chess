require "./Pieces.rb"
require "debugger"

class Board

  def self.place_pieces
    blacks = [Castle.new(:B, [0,0], ), Knight.new(:B, [1,0]), Bishop.new(:B, [2,0]),
              Queen.new(:B, [3, 0]), King.new(:B, [4, 0]), Bishop.new(:B, [5,0]),
              Knight.new(:B, [6, 0]), Castle.new(:B, [7, 0])]

    whites = [Castle.new(:W, [0, 7]), Knight.new(:W, [1, 7]), Bishop.new(:W, [2, 7]),
              Queen.new(:W, [3,7]), King.new(:W, [4, 7]), Bishop.new(:W, [5, 7]),
              Knight.new(:W, [6, 7]), Castle.new(:W, [7,7])]

    black_pawns = Array.new(8) { Pawn.new(:B, [0, 1]) }
    1.upto(8) { |i| black_pawns[i - 1].position = [i - 1, 1] }

    white_pawns = Array.new(8) { Pawn.new(:W, [0, 6]) }
    1.upto(8) { |i| white_pawns[i - 1].position = [i - 1, 6] }

    board = Array.new(8) { Array.new(8) }

    board[0] = blacks
    board[1] = black_pawns
    board[6] = white_pawns
    board[7] = whites

    board
  end

  attr_accessor :board, :captured_pieces

  def initialize
    @board = Board.place_pieces
    @captured_pieces = []
  end

  def same_color(start_pos, move_pos)
    return false if self[move_pos].nil?
    self[start_pos].color == self[move_pos].color
  end

  def valid_position?(start_pos, move_pos)
    (move_pos.all? { |coord| (0..7).include?(coord) }) && (!same_color(start_pos, move_pos))
  end

  def valid_moves(start_position)
    piece = self[start_position]

    if piece.is_a?(SlidingPiece)
      new_moves = filter_sliding_moves(piece).select do |new_position|
        valid_position?(start_position, new_position)
      end
    elsif piece.is_a?(Pawn)
      new_moves = piece.moves.select { |new_position| valid_position?(start_position, new_position) }
      movable_moves = [new_moves.first]
      movable_moves += [new_moves.last] if piece.moves.length == 4
      movable_moves += new_moves[1..2].select do |position|
         !self[position].nil?
       end
    new_moves = movable_moves
    else # All other pieces
      new_moves = piece.moves.select do |new_position|
        valid_position?(start_position, new_position)
      end
    end

    new_moves
  end

  def filter_sliding_moves(piece)
    valid_moves = []

    piece.moves.each do |path|
      path.each do |pos|
        if self[pos] && self[pos].color == piece.color
          break
        elsif self[pos] && self[pos].color != piece.color
          valid_moves << pos
          break
        else
          valid_moves << pos
        end
      end
    end

    valid_moves
  end


  def make_move(from, to)
    captured_pieces << self[to] if self[to]
    self[from].position = to
    self[to], self[from] = self[from], nil
    self[to].first_move = false if self[to].is_a?(Pawn)
    # capture_piece(self[to])
    # p piece.moves
    # p new_moves
  end

  def make_safe_move(from, to)
    piece1, piece2 = self[from], self[to]
    self[from].position = to
    self[to], self[from] = self[from], nil
    in_check = in_check?(piece1.color)
    self[from], self[to] = piece1, piece2
    self[from].position = from

    in_check
  end

  def left_in_check?(start_pos, move_pos)
    make_safe_move(start_pos, move_pos)
  end

  def [](pos)
    x, y = pos
    return nil if y > 7
    board[y][x]
  end

  def []=(pos, mark)
    x, y = pos
    return nil if y > 7
    board[y][x] = mark
  end

  def render
    puts "Black has captured: #{captured_pieces.select do |piece|
                              piece.color == :W
                              end.map { |piece| piece.graphic } }"

    puts "   #{("A".."H").to_a.join('  ')}"
    0.upto(7) do |n|
      puts "#{n}  #{board[n].map do |pos|
        pos ? pos.graphic : "□"
      end.join("  ")}"
    end

    puts "White has captured: #{captured_pieces.select do |piece|
                              piece.color == :B
                              end.map { |piece| piece.graphic } }"
  end

  def inspect
    puts
    render
    puts
  end

  def in_check?(color)
    opposing_piece_moves = []
    king = nil
    board.each do |row|
      row.each do |piece|
        king = piece if piece.is_a?(King) && piece.color == color
        if piece.is_a?(Piece) && piece.color != color
          opposing_piece_moves << valid_moves(piece.position)
        end
      end
    end
    opposing_piece_moves.each do |move|
      return true if move.any? { |pos| pos == king.position }
    end

    false
  end

  def checkmate?(color)
    color_pieces = []
    board.each do |row|
      row.each do |piece|
        color_pieces << piece if piece.is_a?(Piece) && piece.color == color
      end
    end

    color_pieces.each do |piece|
      valid_moves(piece.position).each do |move|
        return false unless left_in_check?(piece.position, move)
      end
    end

    true
  end

end







