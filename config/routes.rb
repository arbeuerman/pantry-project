Rails.application.routes.draw do
  resources :ingredients, only: [:index]
  get '/ingredients/new/:recipe_id', to: 'ingredients#new', as: 'new_ingredient'
  post '/ingredients', to: 'ingredients#create'

  get '/recipes/home', to: 'recipes#home', as: 'recipe_home'
  get '/recipes', to: 'recipes#user_recipes', as: 'user_recipes'
  post '/recipes/completed/:id', to: 'recipes#completed', as: 'recipe_completed'
  get '/recipes/all', to: 'recipes#index', as: 'recipes'
  post '/recipes/all', to: 'recipes#create'
  resources :recipes, only: [:show, :new]
  

  resources :pantries, only: [:index, :create]  
  get '/users/:id/pantry', to: 'pantries#user_pantry', as: 'user_pantry'
  get '/users/:id/pantry/new', to: 'pantries#new', as: 'add_to_pantry'
  get '/users/:id/pantry/edit', to: 'users#edit', as: 'remove_from_pantry'
  patch '/users/:id', to: 'users#update'
  delete '/logout', to: 'users#delete'

  #resources :foods

  resources :users, only: [:index, :show, :new, :create]

  get '/login', to: 'sessions#new', as: "login"
  post '/login', to: 'sessions#create'
  #get '/users', to: 'users#index', as: 'users'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
