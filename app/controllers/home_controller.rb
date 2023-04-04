class HomeController < ApplicationController

    def index
        @boards = Board.last(10)
    end
end