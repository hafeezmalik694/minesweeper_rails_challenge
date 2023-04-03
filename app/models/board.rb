class Board < ApplicationRecord
    validates_presence_of :name, :email

    def update_cell(row, col)
        cell = board[row][col]
        cell[:revealed] = true
        if cell[:mine]
          # handle game over logic (e.g. reveal all mines)
        elsif cell[:adjacent_mines] == 0
          # recursively reveal all adjacent cells with no adjacent mines
          board[row][col][:revealed] = true
          (row - 1..row + 1).each do |r|
            (col - 1..col + 1).each do |c|
              update_cell(r, c)
            end
          end
        end
        save
    end
end
  