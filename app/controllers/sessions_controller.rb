class SessionsController < ApplicationController
    def new 
    
    end 
  
    def create
      # find the user in the database by the name
      @user = User.find_by(username: params[:username])
      if @user
        session[:user_id] = user.id 
        redirect_to user_path(user)
      else
        flash[:errors] = "Incorrect username, please try again or sign up for an account"
        # byebug
        redirect_to login_path
      end

    end
  
end