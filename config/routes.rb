Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :food, only: [:index, :new, :create, :destroy]
  root "food#index"

  resources :food, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_food, only: [:new, :create]
  end
  resources :recipe_foods, only: [:new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :recipe_food, only: [:destroy]
  resources :general_shopping_list, only: [:index]
end