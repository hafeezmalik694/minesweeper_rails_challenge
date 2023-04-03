module ApplicationHelper
    def cell_class(cell)
        classes = []
        classes << 'cell-revealed' if cell['revealed']
        classes << "cell-adjacent-#{cell['adjacent_mines']}" if cell['adjacent_mines']
        classes << 'cell-mine' if cell['mine']
        classes.join(' ')
    end
end
