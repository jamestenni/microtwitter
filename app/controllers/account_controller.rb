class AccountController < ApplicationController
  include SessionConcern 
  before_action :is_logged_in, only: %i[feedpage profilepage]
  before_action :set_user, only: %i[feedpage profilepage]

  def feedpage

  end

  def profilepage

  end

end
