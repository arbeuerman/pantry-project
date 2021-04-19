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

    def destroy
    end

    private 
    def pantry_params
        params.require(:pantry).permit(:food_id)
    end

end
