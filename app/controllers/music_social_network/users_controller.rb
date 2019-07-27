module MusicSocialNetwork
  class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
      @users = User.all
    end

    def profile
    end

    def own_posts
      @own_posts = current_user.posts
    end
  end
end
