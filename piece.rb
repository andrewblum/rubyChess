require 'singleton'

module SlidingPiece
  def moves
  end

  def move_dirs
  end
end

module SteppingPiece
end

class Piece
  attr_accessor :type, :side, :pos

  def initialize(type, side, pos, board)
    @type = type
    @side = side
    @pos = pos
    @board = board
  end
  def moves
  end

end

class Pawn < Piece
end

class Bishop < Piece
  include SlidingPiece

end

class Rook < Piece
  include SlidingPiece

end

class Queen < Piece
  include SlidingPiece
end

class Knight < Piece
  include SteppingPiece
end

class King < Piece
  include SteppingPiece
end

class NullPiece < Piece
  include Singleton
  def initialize()
  end
end
