require_relative 'piece.rb'
class Board
  def initialize()
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance} }
    populate
  end


  def populate
    pawns = ["Pn"] * 8
    board_ref = self
    pawns.each_with_index do |each, i|
      @grid[i][1] = Pawn.new(each, "black", [i, 1], board_ref)
    end

    pawns.each_with_index do |each, i|
      @grid[i][6] = Pawn.new(each, "white", [i, 6], board_ref)
    end

    @grid[3][7] = Queen.new("Qu", "white",[3,7], board_ref)
    @grid[3][0] = Queen.new("Qu", "black",[3,0], board_ref)
    @grid[4][7] = King.new("Ki", "white",[4,7], board_ref)
    @grid[4][0] = King.new("Ki", "black",[4,0], board_ref)

    @grid[0][0] = Rook.new("Rk", "black",[0, 0], board_ref)
    @grid[0][7] = Rook.new("Rk", "white",[0, 7], board_ref)
    @grid[7][0] = Rook.new("Rk", "black",[7, 0], board_ref)
    @grid[7][7] = Rook.new("Rk", "white",[7, 7], board_ref)

    @grid[1][0] = Knight.new("Kn", "black",[1, 0], board_ref)
    @grid[1][7] = Knight.new("Kn", "white",[1, 7], board_ref)
    @grid[6][0] = Knight.new("Kn", "black",[6, 0], board_ref)
    @grid[6][7] = Knight.new("Kn", "white",[6, 7], board_ref)

    @grid[2][0] = Bishop.new("Bp", "black",[2, 0], board_ref)
    @grid[2][7] = Bishop.new("Bp", "white",[2, 7], board_ref)
    @grid[5][0] = Bishop.new("Bp", "black",[5, 0], board_ref)
    @grid[5][7] = Bishop.new("Bp", "white",[5, 7], board_ref)

  end


  def [](pos)
    @grid[pos[1]][pos[0]]
  end

  def []=(pos, value)
    @grid[pos[1]][pos[0]] = value
  end

  def move_piece(start_pos, end_pos)
    x, y = start_pos
    if self[[x, y]].is_a?(NullPiece)
      puts ("No piece there")
      sleep(1)
      return
    end
    j , i = end_pos

    p self[[x, y]].moves
    p [i, j]
    if not self[[x, y]].moves.include?([i, j])
      puts "Invalid move"
      sleep(1)
      return
    end

    p self[[x, y]].pos
    self[[x, y]].pos = [i, j]
    p self[[x, y]].pos
    sleep(1)
    self[[x, y]] = self[[i ,j]]
    self[[x, y]] = NullPiece.instance



  end




end
