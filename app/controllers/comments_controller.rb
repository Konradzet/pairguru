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

  def top_commentators
    @commentators = Comment
      .select("COUNT(comments.user_id) as comments_count, users.*")
      .joins(:user)
      .where("comments.created_at >= :date", date: 7.days.ago)
      .group(:user_id)
      .order("comments_count DESC")
      .limit(10)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :movie_id)
  end

  

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
