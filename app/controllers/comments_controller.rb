class CommentsController < ApplicationController
  before_action :set_movie
  before_action :authenticate_user!

  def create
    @comment = @movie.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = @movie.comments.find(params[:id])
    @comment.destroy

    redirect_to movie_path(@movie)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :movie_id)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
