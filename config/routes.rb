Rails.application.routes.draw do

  root to: 'homes#top'
  get '/homes/about' => 'homes#about', as: 'about'
  get '/homes/top' => 'homes#top', as: 'top'

  devise_for :users

  resources :books, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :users, :index] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  get 'search' => 'searches#search'

  resources :chats, only: [:show, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
