class BoardGenerator

  def self.generate_board(height, width, num_mines)
    board = []
    for i in 0...height do
      row = []
      for j in 0...width do
        row << { mine: false, adjacent_mines: 0, revealed: false, flag: false }
      end
      board << row
    end
  
    # place mines randomly
    num_mines_placed = 0
    while num_mines_placed < num_mines do
      x = rand(width)
      y = rand(height)
      if !board[y][x][:mine]
        board[y][x][:mine] = true
        num_mines_placed += 1
      end
    end
  
    # count adjacent mines
    for i in 0...height do
      for j in 0...width do
        if board[i][j][:mine]
          next
        end
        count = 0
        for ii in -1..1 do
          for jj in -1..1 do
            if i + ii >= 0 and i + ii < height and j + jj >= 0 and j + jj < width and board[i + ii][j + jj][:mine]
              count += 1
            end
          end
        end
        board[i][j][:adjacent_mines] = count
      end
    end
  
    return board
  end
  
end
