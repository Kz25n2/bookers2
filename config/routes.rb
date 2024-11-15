Rails.application.routes.draw do

  root to: 'application#main'
  get '/homes/about' => 'homes#about', as: 'about'

  devise_for :users

  resources :books, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :users, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
