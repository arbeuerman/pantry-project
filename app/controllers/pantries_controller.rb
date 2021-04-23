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
        if @pantry.valid?
            redirect_to user_pantry_path(current_user)
        else
            flash[:errors] = @pantry.errors.full_messages
            redirect_to add_to_pantry_path(current_user)
        end
    end 

    

    private 
    def pantry_params
        params.require(:pantry).permit(:food_id)
    end

end
