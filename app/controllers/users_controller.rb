class UsersController < ApplicationController

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

    private
    def user_params
        params.require(:user).permit(:foods)
    end
end
