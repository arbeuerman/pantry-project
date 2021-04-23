require 'faker'
I18n.reload!
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.destroy_all
Ingredient.destroy_all
Ingredient.reset_pk_sequence
# Pantry.destroy_all
# Pantry.reset_pk_sequence
# Recipe.destroy_all
# Recipe.reset_pk_sequence
# Food.destroy_all
# Food.reset_pk_sequence
# User.destroy_all
# User.reset_pk_sequence

# Faker::Config.locale = :en

# 10.times do 
#     # byebug
#     User.create(username: Faker::Creature::Animal.name.downcase, password: 'abc123', dietary_restriction: %w(vegan vegetarian gluten-free).sample)
# end
I18n.reload!

def request_api(url)
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

def find_recipes(letter)
  request_api(
  "https://www.themealdb.com/api/json/v1/1/search.php?f=#{letter}"
  )
end

def get_recipe_info(id)
  request_api(
      "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  )
end

def get_ingredients()
    request_api(
        "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
    )
end

def get_ingredients_amounts (recipe_hash)
    ingredients = get_ingredients_for_recipe(recipe_hash)
    amounts = get_amounts(recipe_hash)
    Hash[ingredients.zip(amounts)]
end

def get_ingredients_for_recipe(recipe_hash)
    ingredients = []
    recipe_hash.each do |category, value|
        if category.include?("strIngredient") && value != nil && value != "" 
            ingredients << value
        end 
    end
    ingredients
end

def get_amounts(recipe_hash)
    amounts = []
    recipe_hash.each do |category, value|
        if category.include?("strMeasure") && value != nil && value != "" 
            amounts << value
        end 
    end
    amounts
end

# 5.times do 
#     letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).sample
#     recipes = find_recipes(letter)
#     if recipes && recipes.size > 0
#         recipes.each do |recipe|
#             #recipe_info = get_recipe_info(recipe["idMeal"])
#             Recipe.create(name: recipe["strMeal"], 
#             meal: recipe["strCategory"], 
#             cuisine: recipe["strArea"], instructions: recipe["strInstructions"], completed: true,
#             api_id: recipe["idMeal"])
#         end
#     end
# end

# food_items = get_ingredients 
# food_items.each do |food_item|
#     Food.create(name: food_item["strIngredient"].downcase, type_of_food: food_item["strType"])
# end

# 60.times do 
#     Pantry.create(user_id: User.all.sample.id, food_id: Food.all.sample.id)
# end

Recipe.all.each do |recipe|
    recipe_ingredients = get_recipe_info(recipe.api_id)
    ingredients_amounts = get_ingredients_amounts(recipe_ingredients[0])
    
    ingredients_amounts.each do |ingredient, amount|
        food = nil
        if ingredient == "Carrots"
            # byebug
            food = Food.find_by(name: "carrot")
        else
            food = Food.find_by(name: ingredient.downcase)
        end
        # byebug
        if food
            Ingredient.create(recipe_id: recipe.id, food_id: food.id, amount: amount)
        else
            puts "#{ingredient} does not have a corresponding food in the foods table"
        end
    end
end




    