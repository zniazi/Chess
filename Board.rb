require "./Pieces.rb"

class Board

  def self.place_pieces
    blacks = [Castle.new(:B, [0,0]), Knight.new(:B, [1,0]), Bishop.new(:B, [2,0]),
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

  attr_accessor :board

  def initialize
    @board = Board.place_pieces
  end

  def same_color(start_pos, move_pos)
    return false if self[move_pos].nil?
    self[start_pos].color == self[move_pos].color
  end

  def valid_position?(start_pos, move_pos)
    move_pos.all? { |coord| (0..7).include?(coord) } && !same_color(start_pos, move_pos)
  end

  def valid_moves(start_position)
    piece = self[start_position]
    x, y = start_position
    new_moves = piece.moves.map { |dx, dy| [x + dx, y + dy] }
    new_moves = new_moves.select { |new_position| valid_position?(start_position, new_position) }
    p piece.moves
    p new_moves
  end

  def [](pos)
    x, y = pos
    board[y][x]
  end

  def []=(pos, mark)
    x, y = pos
    board[y][x] = mark
  end

  def render
    puts "   #{("A".."H").to_a.join('  ')}"
    1.upto(8) do |n|
      puts "#{n}  #{board[n - 1].map do |pos|
        pos ? pos.graphic : "□"
      end.join("  ")}"
    end
  end

  def inspect
    puts
    render
    puts
  end

  def check(color)

  end

end


