class Board < ApplicationRecord
    validates_presence_of :name, :email

    def update_cell(row, col)
      cell = board[row][col]
      cell['revealed'] = true
      if cell['mine']
        # handle game over logic (e.g. reveal all mines)
        self.playing = false
      elsif cell['adjacent_mines'] == 0
        # recursively reveal all adjacent cells with no adjacent mines
        (row - 1..row + 1).each do |r|
          (col - 1..col + 1).each do |c|
            next if r < 0 || r >= self.rows.to_i || c < 0 || c >= self.columns.to_i || board[r][c]['revealed']
            update_cell(r, c)
          end
        end
        # reveal_adjacent_cells(row, col)
      end
      save
    end
    
    def update_cell_flag(row, col)
      cell = board[row][col]
      cell['flag'] = true
      save
    end

    # def reveal_adjacent_cells(row, col)
    #   # Base case: return if cell is not blank or already revealed
    #   return if !in_bounds(row, col) || revealed?(row, col) || !blank?(row, col)
      
    #   # Reveal the current cell
    #   reveal(row, col)
      
    #   # Recursively reveal all adjacent cells
    #   reveal_adjacent_cells(row - 1, col)  # North
    #   reveal_adjacent_cells(row + 1, col)  # South
    #   reveal_adjacent_cells(row, col - 1)  # West
    #   reveal_adjacent_cells(row, col + 1)  # East
    #   reveal_adjacent_cells(row - 1, col - 1)  # Northwest
    #   reveal_adjacent_cells(row - 1, col + 1)  # Northeast
    #   reveal_adjacent_cells(row + 1, col - 1)  # Southwest
    #   reveal_adjacent_cells(row + 1, col + 1)  # Southeast
    # end

    # def in_bounds(row, col)
    #   debugger
    #   row >= 0 && row < self.rows && col >= 0 && col < self.columns
    # end
    
    # def revealed?(row, col)
    #   @board[row][col].revealed
    # end
    
    # def blank?(row, col)
    #   @board[row][col].adjacent_mines == 0
    # end
end
  