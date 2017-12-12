require_relative 'piece.rb'
class Board
  def initialize()
    @grid = Array.new(8) { Array.new(8) {Array.new()} }
    populate
  end


  def populate
    pawns = ["Pn"] * 8
    board_ref = self
    pawns.each_with_index do |each, i|
      @grid[i][1] = Piece.new(each, "black", [i, 1], board_ref)
    end

    pawns.each_with_index do |each, i|
      @grid[i][6] = Piece.new(each, "white", [i, 6], board_ref)
    end

    @grid[3][7] = Piece.new("Qu", "white",[3,7], board_ref)
    @grid[3][0] = Piece.new("Qu", "black",[3,0], board_ref)
    @grid[4][7] = Piece.new("Ki", "white",[4,7], board_ref)
    @grid[4][0] = Piece.new("Ki", "black",[4,0], board_ref)

    non_pawn = ["Rk", "Kn", "Bp"]
    (0..2).to_a.each do |i|
      type = non_pawn[i]
      p "type: #{type}"
      @grid[i][0] = Piece.new(type, "black",[i, 0], board_ref)
      @grid[i][7] = Piece.new(type, "white",[i, 7], board_ref)
      @grid[7-i][0] = Piece.new(type, "black",[7-i, 0], board_ref)
      @grid[7-i][7] = Piece.new(type, "white",[7-i, 7], board_ref)
    end
    @grid = @grid.transpose
  end


  def [](x, y)
    @grid[x][y]
  end

  def move_piece(start_pos, end_pos)
    x, y = start_pos
    raise StandardError.new("No piece there") if @grid[x][y] == nil
    i, j = end_pos
    @grid[x][y], @grid[i][j] = @grid[i][j], @grid[x][y]
  end




end
