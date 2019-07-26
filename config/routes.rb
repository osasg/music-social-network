Rails.application.routes.draw do
  root to: 'home#index'

  resources :posts

  devise_for :users

  resources :comments, only: [:create, :destroy]

  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
end
