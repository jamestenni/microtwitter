class MainController < ApplicationController
  include SessionConcern 
  before_action :initialize_new_user, only: %i[ loginpage registerpage ]

  #Login -------------------------------------
  def loginpage
    #if the user has already logged in before, move the user to the feed page automically
    if (has_logged_in)
      redirect_to feed_page_path()
    end
  end

  def checklogin
    user = User.find_by(email: params[:user][:email])
    if (user != nil and user.authenticate(params[:user][:password]))
      #Login success
      session[:user_id] = user.id #Save session
      redirect_to feed_page_path()
    else
      #Login failed
      redirect_to login_page_path(), alert: "Your email or password is incorrect!"
    end
  end

  #Register Page -------------------------------------
  def registerpage
  
  end

  def registration
    @user = User.new(user_params)
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]

    if @user.save #registration completed
      redirect_to login_page_path, notice: "Registration completed! Now you can login to our microtwitter world!"
    else #registration failed / invalid input
      render :registerpage
    end
  end


  private
    def initialize_new_user
      @user = User.new();
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
