module MusicSocialNetwork
  class FollowsController < ApplicationController
    before_action :authenticate_user!
    respond_to :js

    def create
      return if params[:user_id] == current_user.id

      @user = User.find(params[:user_id])
      current_user.follow(@user)
    end

    def destroy
      @user = User.find(params[:user_id])
      current_user.stop_following(@user)
    end
  end
end
