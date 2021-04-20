class IngredientsController < ApplicationController

    def new
        @ingredient = Ingredient.new
        @foods = Food.all
        @recipes = Recipe.all
    end

    def create
        @ingredient = Ingredient.create(ingredient_params)
        redirect_to recipe_path(@ingredient.recipe)
    end

    private 
    def ingredient_params
        params.require(:ingredient).permit(:recipe_id, :food_id, :amount)
    end
end
