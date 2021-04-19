class ApplicationController < ActionController::Base

    def login
        render :new
    end 

    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end
end
