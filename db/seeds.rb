# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.destroy_all
# # User.reset_pk_sequence
Ingredient.destroy_all
Pantry.destroy_all
Recipe.destroy_all
Food.destroy_all
User.destroy_all

10.times do 
    User.create(username: Faker::Creature::Animal.name.downcase, password: Faker::Color.unique.color_name, dietary_restriction: %w(vegan vegetarian gluten-free).sample)
end

20.times do 
    Food.create(name: Faker::Food.unique.fruits, type_of_food: 'fruit')
end

20.times do 
    Food.create(name: Faker::Food.unique.vegetables, type_of_food: 'vegetable')
end

20.times do 
    Food.create(name: Faker::Food.unique.ingredients, type_of_food: 'other')
end

20.times do 
    Recipe.create(name: Faker::Food.unique.dish, 
    meal: %w(Breakfast Lunch Dinner).sample, 
    cuisine: %w(Italian Thai American Brazilian Ethiopian Colombian).sample, instructions: Faker::Food.description, completed: true)
end

60.times do 
    Pantry.create(user_id: User.all.sample.id, food_id: Food.all.sample.id)
end

100.times do
    Ingredient.create(recipe_id: Recipe.all.sample.id, food_id: Food.all.sample.id, amount: Faker::Food.measurement)
end