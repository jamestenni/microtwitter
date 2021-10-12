class AccountController < ApplicationController
  include SessionConcern 
  before_action :is_logged_in, only: %i[feedpage]
  before_action :set_user, only: %i[feedpage]

  def feedpage

  end

end
