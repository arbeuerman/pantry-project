class Recipe < ApplicationRecord
    has_many :ingredients
    has_many :foods, through: :ingredients
    #hi testing branches
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :meal, inclusion: {in: %w(Breakfast Lunch Dinner Snack), message: "%{value} is not a valid meal type"}
    #validates :instructions, length: {minimum: 1 }

    def self.recipe_book
        recipes = {}
        Recipe.all.each do |recipe|
            recipes[recipe] = recipe.foods
        end
        recipes
    end
end
