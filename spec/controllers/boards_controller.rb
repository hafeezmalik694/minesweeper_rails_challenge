require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
    describe 'GET #index' do
      it 'assigns all boards to @boards' do
        board = FactoryBot.create(:board)
        get :index
        expect(assigns(:boards)).to eq([board])
      end
  
      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  
    describe 'GET #new' do
      it 'assigns a new board to @board' do
        get :new
        expect(assigns(:board)).to be_a_new(Board)
      end
  
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end
  
    describe 'POST #create' do
      context 'with valid parameters' do
        let(:board_params) { FactoryBot.attributes_for(:board) }
  
        it 'saves the new board in the database' do
          expect {
            post :create, params: board_params 
          }.to change(Board, :count).by(1)
        end
  
        it 'redirects to the board show page' do
          post :create, params: board_params
          expect(response).to redirect_to(board_path(assigns(:board)))
        end
      end
  
      context 'with invalid parameters' do
        let(:board_params) { FactoryBot.attributes_for(:board, name: nil) }
  
        it 'does not save the new board in the database' do
          expect {
            post :create, params: { board: board_params }
          }.to_not change(Board, :count)
        end
  
        it 're-renders the new template' do
          post :create, params: { board: board_params }
          expect(response).to render_template(:new)
        end
      end
    end
  
    describe 'GET #show' do
      let(:board) { FactoryBot.create(:board) }
  
      it 'assigns the requested board to @board' do
        get :show, params: { id: board.id }
        expect(assigns(:board)).to eq(board)
      end
  
      it 'updates the board playing status to true' do
        expect {
          get :show, params: { id: board.id }
          board.reload
        }.to change(board, :playing).to(true)
      end
  
      it 'renders the show template' do
        get :show, params: { id: board.id }
        expect(response).to render_template(:show)
      end
    end
  
    describe "post #reveal_cell" do
      let(:board) { FactoryBot.create(:board) }
      let(:row) { 1 }
      let(:col) { 1 }
  
      it "assigns the requested board to @board" do
        post :reveal_cell, params: { id: board.id, row: row, col: col }
        expect(assigns(:board)).to eq(board)
      end
  
      it "updates the cell at the specified row and column" do
        expect_any_instance_of(Board).to receive(:update_cell).with(row, col)
        post :reveal_cell, params: { id: board.id, row: row, col: col }
      end
  
      it "responds with a JS template" do
        post :reveal_cell, params: { id: board.id, row: row, col: col }, format: :js
        expect(response.content_type).to eq "text/javascript"
      end
    end
  end
  