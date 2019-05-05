class BoardsController < ApplicationController
    before_action :set_target_board, only: %i[show edit update destroy]
  
    def index
      # タグ検索
      if params[:tag_id].present? then
        @boards = Tag.find(params[:tag_id]).boards
      # サーチボックス検索
      elsif params[:search].present? then
        @boards = Board.where(['name LIKE ?', "%#{params[:search]}%"])
      else
        @boards = Board.all
      end
      @boards = @boards.page(params[:page])
    end
  
    def new
      @board = Board.new(flash[:board])
    end
  
    def create
      board = Board.new(board_params)
      if board.save
        flash[:notice] = "「#{board.title}」の掲示板を作成しました"
        redirect_to board
      else
        redirect_to :back, flash: {
          board: board,
          error_messages: board.errors.full_messages
        }
      end
    end
  
    def show
      @comment = Comment.new(board_id: @board.id)
    end
  
    def edit
      @board.attributes = flash[:board] if flash[:board]
    end
  
    def update
      if @board.update(board_params)
        redirect_to @board
      else
        redirect_to :back, flash: {
          board: @board,
          error_messages: @board.errors.full_messages
        }
      end
    end
  
    def destroy
      @board.destroy
      redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました" }
    end
  
    private
  
    def board_params
      params.require(:board).permit(:name, :title, :body, tag_ids: [])
    end
  
    def set_target_board
      @board = Board.find(params[:id])
    end
  end