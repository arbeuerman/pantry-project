class Recipe < ApplicationRecord
    has_many :ingredients
    has_many :foods, through: :ingredients

    validates :name, presence: true
    validates :name, uniqueness: true
    #validates :meal, inclusion: {in: %w(Breakfast Lunch Dinner Snack Dessert), message: "%{value} is not a valid meal type"}
    #validates :instructions, length: {minimum: 1 }

    def self.recipe_book
        recipes = {}
        Recipe.all.each do |recipe|
            food_names = recipe.foods.map { |food| food.name }
            recipes[recipe] = food_names
        end
        recipes
    end

    # def list_instructions
    #     #create a regex to split on. any number followed by a period
    #     #delimiter = /[1-20].\/
    #     self.instructions.match
    # end
end
