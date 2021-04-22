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

    def show
        user = User.find(params[:id])
        session[:user_id] = user.id
    end
    
    def edit
        @user_foods = @current_user.foods
    end

    def update
        pantry_item = Pantry.find(params[:user][:foods])
        food_to_remove = @current_user.foods.find(pantry_item.id)
        @current_user.foods.delete(food_to_remove)
        redirect_to user_pantry_path(@current_user.id)
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
