class AccountController < ApplicationController
  include SessionConcern 
  before_action :is_logged_in, only: %i[feedpage profilepage createpostpage createpost]
  before_action :set_user, only: %i[feedpage profilepage createpostpage createpost]

  def feedpage

  end

  def profilepage
    @user_profile = User.find_by(name: params[:name])
    @post = @user_profile.posts.reverse()

    @isMyself = @user.id == @user_profile.id
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

  private
    def post_params
      params.require(:post).permit(:msg, :user_id)
    end
end
