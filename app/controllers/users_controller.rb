class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(params.require(:user).permit(:username, :password, :dietary_restriction))
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def index
        @users = User.all
    end

    def show
        user = User.find(params[:id])
        session[:user_id] = user.id
        current_user
    end
    
    def edit
        @user = current_user
        @user_foods = @user.foods
    end

    def update
        @user = current_user
        pantry_item = Pantry.find(params[:user][:foods])
        food_to_remove = @user.foods.find(pantry_item.id)
        @user.foods.delete(food_to_remove)
        redirect_to user_pantry_path(@user.id)
    end

    def delete
        session[:user_id] = nil
        redirect_to login_path
    end

    private
    def user_params
        params.require(:user).permit(:foods)
    end
end
