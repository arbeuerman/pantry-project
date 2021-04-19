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
end
