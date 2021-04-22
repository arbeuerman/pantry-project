require 'excon'

class RecipesController < ApplicationController
    
    def home 
    end

    def index
        @recipes = find_recipes
    end

    def user_recipes 
    end

    def show
        @recipe = get_recipe_info(params[:id])[0]
        @ingredients_amounts = get_ingredients_amounts(@recipe)
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
        byebug
        @recipe.update(completed: params[:button])
        redirect_to recipe_path(@recipe.id)
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :meal, :cuisine, :instructions)
    end

    def request_api(url)
    #   byebug
      response = Excon.get(
        url,
        headers: {
          'Host' => URI.parse(url).host
        }
      )
      return nil if response.status != 200
      parsed = JSON.parse(response.body)
      new_array = parsed.map { |recipe| recipe }[0] # looks like ["meals", [{recipe 1},{recipe 2}]]  
      new_array[1]
    end

    def find_recipes()
      request_api(
        "https://www.themealdb.com/api/json/v1/1/search.php?f=b"
      )
    end

    def get_recipe_info(id)
        request_api(
            "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
        )
    end


    def get_ingredients_amounts (recipe_hash)
        ingredients = get_ingredients(recipe_hash)
        amounts = get_amounts(recipe_hash)
        Hash[ingredients.zip(amounts)]
    end

    def get_ingredients(recipe_hash)
        ingredients = []
        recipe_hash.select do |category, value|
            if category.include?("strIngredient") && value != nil && value != "" 
                ingredients << value
            end 
        end
        ingredients
    end

    def get_amounts(recipe_hash)
        amounts = []
        recipe_hash.select do |category, value|
            if category.include?("strMeasure") && value != nil && value != "" 
                amounts << value
            end 
        end
        amounts
    end
end
