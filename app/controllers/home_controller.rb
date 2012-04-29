class HomeController < ApplicationController
  skip_filter :authenticate_user!, :only => [ :welcome , :new_user_sign_up]
  def dashboard
  end
  
  def welcome
  end
  
  def new_user_sign_up
  end
end
