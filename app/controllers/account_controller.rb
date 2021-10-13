class AccountController < ApplicationController
  include SessionConcern 
  before_action :is_logged_in, only: %i[feedpage profilepage createpostpage]
  before_action :set_user, only: %i[feedpage profilepage createpostpage]

  def feedpage

  end

  def profilepage
    @user_profile = User.find_by(name: params[:name])
    @post = @user_profile.posts.reverse()

    @isMyself = @user.id == @user_profile.id
  end

  def createpostpage
  
  end

end
