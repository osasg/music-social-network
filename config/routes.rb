Rails.application.routes.draw do
  root to: 'home#index'

  resources :posts

  scope :users, controller: :users, as: :users do
    get :profile, action: :profile, as: :profile
    get :own_posts, action: :own_posts, as: :own_posts
  end

  devise_for :users

  resources :comments, only: [:create, :destroy]

  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
end
