class Recipe < ApplicationRecord
    has_many :ingredients
    has_many :foods, through: :ingredients

    def self.recipe_book
        recipes = {}
        Recipe.all.each do |recipe|
            recipes[recipe] = recipe.foods
        end
        recipes
    end
end
