class User < ApplicationRecord
    has_many :pantries
    has_many :foods, through: :pantries

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

    private
    def request_api(url)
        #   byebug
        #key: 9973533
          response = Excon.get(
            url,
            headers: {
              'Host' => URI.parse(url).host
            }
          )
          return nil if response.status != 200
          parsed = JSON.parse(response.body)
          new_array = parsed.map { |recipe| recipe }[0] # looks like ["meals", [{recipe 1},{recipe 2}]]  
          byebug
          new_array[1]
        end
    
        def find_user_recipes(user_foods)
          request_api(
            "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{user_foods}"
          )
        end
end
