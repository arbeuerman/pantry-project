class SessionsController < ApplicationController
    def new 
    
    end 
  
    def create
      # find the user in the database by the name
      user = User.find_by(username: params[:username])
      if user
        session[:user_id] = user.id 
        redirect_to user_path(user)
      else
        @errors = "Incorrect username, please try again"
        redirect_to login_path
      end

    end
  
end