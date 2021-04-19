class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        user = User.find(params[:id])
        session[:user_id] = user.id
        current_user
    end
end
