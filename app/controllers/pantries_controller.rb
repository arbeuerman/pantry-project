class PantriesController < ApplicationController

    def user_pantry
        @foods = current_user.foods
    end
    
    def new
        @pantry = Pantry.new
        @foods = Food.all
    end

    def create
        #add food id to user's pantry
        @pantry = Pantry.new(pantry_params)
        @pantry.user_id = current_user.id
        @pantry.save
        redirect_to user_pantry_path(current_user)
    end 

    def edit
        @user = current_user
        @user_foods = @user.foods
    end

    def update
        @user = current_user
        pantry_item = Pantry.find(pantry_params)
        @user.foods.delete(pantry_item)
        redirect_to user_pantry_path(@user.id)
    end

    private 
    def pantry_params
        params.require(:pantry).permit(:food_id)
    end

end
