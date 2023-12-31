# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  
  # Defines the root path route ("/")
  # root "articles#index"
end
