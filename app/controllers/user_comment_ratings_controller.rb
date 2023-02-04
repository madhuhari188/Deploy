class UserCommentRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_topic
  before_action :set_comment


  def create
    @user_comment_rating = @comment.user_comment_ratings.new(user_comment_ratings_params)
    @user_comment_rating.user_id = current_user.id
    # @user_rating=UserCommentRating.where(comment_id: @user_comment_rating.comment_id,user_id: current_user.id).first_or_initialize
    respond_to do |format|
      format.html {
        redirect_to(
          [@topic,@post],
          notice: @user_comment_rating.save ? 'Rating saved successfully.' : 'Rating not saved.'
        )
      }
    end
  end



  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def user_comment_ratings_params
    params.require(:user_comment_rating).permit(:comment_id,:c_rating,:user_id)
  end

end
