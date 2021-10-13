class AccountController < ApplicationController
  include SessionConcern 
  before_action :is_logged_in, only: %i[feedpage profilepage createpostpage createpost]
  before_action :set_user, only: %i[feedpage profilepage createpostpage createpost]

  def feedpage

  end

  def profilepage
    @user_profile = User.find_by(name: params[:name])
    @post = @user_profile.posts.reverse()
    @follower = Follow.where(followee_user_id: @user_profile.id)
    @following = Follow.where(follower_user_id: @user_profile.id)

    @isMyself = @user.id == @user_profile.id
    @follow_enable = Follow.find_by(follower_user_id: @user.id, followee_user_id: @user_profile.id) == nil
  end

  def createpostpage
    @post = Post.new()
  end

  def createpost
    @post = Post.new(post_params)
    @post.user_id = params[:post][:user_id]
    @post.msg = params[:post][:msg]

    puts @post.user_id
    puts @post.msg

    if @post.save
      redirect_to profile_page_path(name: @user.name), notice: "Post created successfully!"
    else
      render :createpostpage
    end
  end

  def createfollow
    @follow = Follow.new(follow_params)
    @follow.followee_user_id = params[:followee_user_id]
    @follow.follower_user_id = params[:follower_user_id]
    @follow.save
    redirect_to profile_page_path(name: User.find(params[:followee_user_id]).name)
  end

  def removefollow
    @follow = Follow.find_by(follower_user_id: params[:follower_user_id], followee_user_id: params[:followee_user_id])
    @follow.destroy
    redirect_to profile_page_path(name: User.find(params[:followee_user_id]).name)
  end

  private
    def post_params
      params.require(:post).permit(:msg, :user_id)
    end

    def follow_params
      params.permit(:follower_user_id, :followee_user_id)
    end
end
