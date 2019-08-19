module MusicSocialNetwork
  class LikesController < ApplicationController
    before_action :find_likeable
    before_action :authenticate_user!
    respond_to :js

    def create
      if current_user.voted_for? @likeable
        head :ok
        return
      end

      @likeable.liked_by current_user

      ActionCable.server.broadcast "likes-#{@likeable[:id]}",
        user_id: current_user[:id],
        post_id: @likeable[:id]
      head :ok
    end

    def destroy
      unless current_user.voted_for? @likeable
        head :ok
        return
      end

      @likeable.unliked_by current_user

      ActionCable.server.broadcast "unlikes-#{@likeable[:id]}",
        user_id: current_user[:id],
        post_id: @likeable[:id]
      head :ok
    end

    private
    def find_likeable
      @likeable_type = params[:likeable_type].classify
      @likeable = @likeable_type.constantize.find(params[:likeable_id])
    end
  end
end
