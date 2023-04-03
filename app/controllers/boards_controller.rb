require 'board_generator'
class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    # Generates and saves the board to the database

    board = BoardGenerator.generate_board(params[:rows].to_i, params[:columns].to_i, params[:mines].to_i)
    board_params = { name: params[:name], email: params[:email], board: board }
    @board = Board.new(board_params)
    if @board.save 
    redirect_to board_path(@board)
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def reveal_cell
    row = params[:row].to_i
    col = params[:col].to_i
    @board = Board.find(params[:id])
    @board.update_cell(row, col)
  end

  private

  def board_params
    params.require(:board).permit(:name, :email, :rows, :columns, :mines, :board)
  end

end