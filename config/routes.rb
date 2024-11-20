Rails.application.routes.draw do

  root to: 'homes#top'
  get '/homes/about' => 'homes#about', as: 'about'
  get '/homes/top' => 'homes#top', as: 'top'

  devise_for :users

  resources :books, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :users, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
