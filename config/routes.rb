Rails.application.routes.draw do
  resources :ingredients

  get '/recipes/home', to: 'recipes#home', as: 'recipe_home'
  get '/recipes', to: 'recipes#user_recipes', as: 'user_recipes'
  get '/recipes/all', to: 'recipes#index', as: 'recipes'
  resources :recipes, only: [:show, :new]
  

  resources :pantries, only: [:index, :create]  
  get '/users/:id/pantry', to: 'pantries#user_pantry', as: 'user_pantry'
  get '/users/:id/pantry/new', to: 'pantries#new', as: 'add_to_pantry'
  delete '/users/:id/pantry/remove', to: 'pantries#destroy', as: 'remove_from_pantry'

  resources :foods

  resources :users, only: [:index, :show]
  get '/', to: 'application#login', as: 'login'
  #get '/users', to: 'users#index', as: 'users'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
