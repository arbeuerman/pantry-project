class SessionsController < ApplicationController
    def new
    end
  
    def create
      # find the user in the database by the name
      user = User.find_by(username: params[:username])
      session[:user_id] = user.id 
      redirect_to user_path(user)
    end
  
end