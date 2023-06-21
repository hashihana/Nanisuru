class Admin::GenresController < ApplicationController
  
  # before_action :authenticate_admin!
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
     @genre = Genre.find(params[:id])
  end
  

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)

      flash[:success] = "更新に成功しました！"
      redirect_to admin_genres_path
    else
      flash[:danger] = "更新に失敗しました。"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
  
end
