Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  scope module: :music_social_network do
    authenticated :user do
      root to: 'home#index'
    end

    unauthenticated :user do
      root to: 'home#guest'
    end

    resources :posts

    scope :users, controller: :users, as: :users do
      get '/', action: :index, as: ''
      get :profile, action: :profile, as: :profile
      get :own_posts, action: :own_posts, as: :own_posts
    end


    resources :comments, only: [:create, :destroy]

    match :follow, to: 'follows#create', as: :follow, via: :post
    match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
    match :unlike, to: 'likes#destroy', as: :unlike, via: :post
    match :like, to: 'likes#create', as: :like, via: :post
  end
  
  devise_for :users
end
