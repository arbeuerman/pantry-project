class RecipesController < ApplicationController
    
    def home 
    end

    def index
        @recipes = Recipe.all
    end

    def user_recipes 
        @user_recipes = @current_user.find_recipes
        # byebug
    end

    def show
        # byebug
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

    def completed
        @recipe = Recipe.find(params[:id])
        #byebug
        @recipe.update(completed: params[:button])
        redirect_to recipe_path(@recipe.id)
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :meal, :cuisine, :instructions, :image_url)
    end
end
