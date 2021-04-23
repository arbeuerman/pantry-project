class User < ApplicationRecord
    has_many :pantries
    has_many :foods, through: :pantries

    validates :username, presence: true
    validates :username, uniqueness: true
    validates :password, presence: true

    def find_recipes
      #get list of all foods that user has in pantry
      user_foods = self.foods 

      #get recipes and their ingredients (foods)
      user_recipes = []
      Recipe.recipe_book.each do |recipe, ingredients_for_recipe| 
          if (ingredients_for_recipe - user_foods).empty?
              user_recipes << recipe
          end
      end
      user_recipes
  end

end
