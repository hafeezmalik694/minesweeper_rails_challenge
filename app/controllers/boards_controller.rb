require 'board_generator'
class BoardsController < ApplicationController
  before_action :set_board, only: [:show]
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    # Generates and saves the board to the database
    board = BoardGenerator.generate_board(params[:rows].to_i, params[:columns].to_i, params[:mines].to_i)
    board_params = { name: params[:name], email: params[:email], columns: params[:columns], rows: params[:rows], board: board, mines: params[:mines] }
    @board = Board.new(board_params)
    if @board.save
    redirect_to board_path(@board)
    else
      render :new
    end
  end

  def show
    @board.update(playing: true)
  end

  def reveal_cell
    row = params[:row].to_i
    col = params[:col].to_i
    @board = Board.find(params[:id])
    @board.update_cell(row, col)

  end

  def add_flag
    row = params[:row].to_i
    col = params[:col].to_i
    @board = Board.find(params[:id])
    @board.update_cell_flag(row, col)
  end

  private 

  def board_params
    params.require(:board).permit[:name, :email, :rows, :columns, :mines, :board]
  end

  def set_board 
    @board = Board.find(params[:id])
    board = BoardGenerator.generate_board(@board.rows.to_i, @board.columns.to_i, @board.mines.to_i)
    @board.update(board: board)
  end

end
