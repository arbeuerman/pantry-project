class RecipesController < ApplicationController

    def home 
        @current_user = current_user
    end

    def index
        @recipes = Recipe.all
        @current_user = current_user
    end

    def user_recipes 
        @current_user = current_user #User.find(params[:id])
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.create(recipe_params)
        if @recipe.valid?
            redirect_to recipe_path(@recipe.id)
        else
            flash[:errors] = @recipe.errors.full_messages
            redirect_to new_recipe_path
        end
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :meal, :cuisine, :description)
    end
end
