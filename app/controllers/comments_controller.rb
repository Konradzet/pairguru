class CommentsController < ApplicationController
  before_action :set_movie, only: [:create, :destroy]
  before_action :authenticate_user!

  def create
    @comment = @movie.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back(fallback_location: root_path, notice: "Comment added")
    else
      redirect_back(fallback_location: root_path, alert: "Error when adding comment")
    end
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

  def top_commentators
    User.joins(:comments).where("comments.created_at > ?", 1.week.ago).distinct
      .order(comments_count: :desc).first(10)

  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
