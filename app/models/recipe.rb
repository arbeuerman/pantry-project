class Recipe < ApplicationRecord
    has_many :ingredients
    has_many :foods, through: :ingredients

    validates :name, presence: true
    validates :name, uniqueness: true

    def self.recipe_book
        recipes = {}
        Recipe.all.each do |recipe|
            recipes[recipe] = recipe.foods
        end
        recipes
    end
end
