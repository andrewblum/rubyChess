require 'colorize'
require 'colorized_string'
require_relative 'Cursor.rb'
require_relative "board.rb"
class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def run
    while true
      system("clear")
      render
      @cursor.get_input
    end
  end

  def render
    i = 0
    checkmark = "\u2713"
    s = checkmark.encode('utf-8').yellow
    x, y = @cursor.cursor_pos
    while i < 8
      puts "-----------------------------------------".red
      temp_row = ""
      j = 0
      while j < 8
        begin
          current = @board[i, j].type
          if @board[i, j].side == "black" && i == x && j == y
            temp_row += " | ".red + current[0].yellow + s
          elsif @board[i, j].side == "white" && i == x && j == y
            temp_row += " | ".red + current[0].yellow + s
          elsif @board[i, j].side == "black"
            temp_row += " | ".red + current.blue
          elsif @board[i, j].side == "white"
            temp_row += " | ".red + current.white
          end
        rescue
          if x == i && j == y
            temp_row += " | ".red + "#{s} ".yellow
          else
            temp_row += " |   ".red
          end
        end
        j += 1
      end
      puts temp_row
      i += 1
    end
    puts "-----------------------------------------".red
  end

  b = Board.new
  d = Display.new(b)
  d.run
end
