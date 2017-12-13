require 'singleton'

module SlidingPiece
  def move_dirs
  end

  def moves
    possible_moves = []
    move_dirs
    @dir.each do |direction|
      x_pos, y_pos = @pos

      if direction == "straight"
        until x_pos == -1 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          x_pos -= 1
        end
        x_pos, y_pos = @pos

        until x_pos == 8 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          x_pos += 1
        end
        x_pos, y_pos = @pos

        until y_pos == 8 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          y_pos += 1
        end
        x_pos, y_pos = @pos

        until y_pos == -1 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          y_pos -= 1
        end

      elsif direction == "diag"

        until x_pos == -1 || y_pos == -1 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          x_pos -= 1
          y_pos -= 1
        end
        x_pos, y_pos = @pos

        until x_pos == 8 || y_pos == -1 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          x_pos += 1
          y_pos -= 1
        end
        x_pos, y_pos = @pos

        until x_pos == -1 || y_pos == 8 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          x_pos -= 1
          y_pos += 1
        end
        x_pos, y_pos = @pos

        until x_pos == 8 || y_pos == 8 || own_piece?([x_pos, y_pos])
          possible_moves << [x_pos, y_pos] unless [x_pos, y_pos] == @pos
          break if capture?([x_pos, y_pos])
          x_pos += 1
          y_pos += 1
        end
      end
    end

    possible_moves
  end
end

module SteppingPiece
  def moves
    diffs = move_diffs
    x_pos, y_pos = @pos
    possible_pos = []

    diffs.each_with_index do |diff_pos, idx|
      diffs[idx] = [diff_pos[0] + x_pos, diff_pos[1] + y_pos]
    end

    diffs.select { |xy| capture?([xy[0], xy[1]]) || @board[[xy[0], xy[1]]].is_a?(NullPiece) }
  end

  def move_diffs
  end
end

class Piece
  attr_accessor :type, :side, :pos

  def initialize(type, side, pos, board)
    @type = type
    @side = side
    @pos = pos
    @board = board
  end

  def capture?(possible_pos)
    return false if @board[possible_pos] == nil
    other_side = @board[possible_pos].side
    @side != other_side
  end

  def own_piece?(possible_pos)
    other_side = @board[possible_pos].side
    return false if @board[possible_pos] == self
    @side == other_side
  end

end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    @dir = ["straight"]
  end

end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    @dir = ["diag"]
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    @dir = ["straight", "diag"]
  end
end

class Knight < Piece
  include SteppingPiece

  def move_diffs
    [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
  end
end

class King < Piece
  include SteppingPiece

  def move_diffs
    x_pos, y_pos = @pos
    [[x_pos, 1], [x_pos, -1], [1, y_pos], [-1, y_pos], [1, -1], [-1, 1], [1, 1], [-1, -1]]
  end
end

class Pawn < Piece
  def moves()
    x_pos, y_pos = @pos
    possible_moves = []
    if @side == "black"
      y_pos += 1
      possible_moves << [x_pos, y_pos] if @board[[x_pos, y_pos]].is_a?(NullPiece)
      possible_moves << [x_pos, y_pos] if capture?([x_pos+1, y_pos])
      possible_moves << [x_pos, y_pos] if capture?([x_pos-1, y_pos])
      possible_moves << [x_pos, y_pos] if @board[[x_pos, y_pos+1]].is_a?(NullPiece)
    else
      y_pos -= 1
      possible_moves << [x_pos, y_pos] if @board[[x_pos, y_pos]].is_a?(NullPiece)
      possible_moves << [x_pos, y_pos] if capture?([x_pos+1, y_pos])
      possible_moves << [x_pos, y_pos] if capture?([x_pos-1, y_pos])
      possible_moves << [x_pos, y_pos] if @board[[x_pos, y_pos-1]].is_a?(NullPiece)
    end
    possible_moves
  end
end


class NullPiece < Piece
  include Singleton
  def initialize()
    @type = nil
    @side = nil
  end
end
