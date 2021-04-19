Rails.application.routes.draw do
  resources :ingredients
  resources :recipes
  resources :pantries
  resources :foods
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
