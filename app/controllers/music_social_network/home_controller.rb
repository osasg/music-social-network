module MusicSocialNetwork
  class HomeController < ApplicationController
    def index
      return unless current_user.present?

      @friends = current_user.all_following
      @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).page(params[:page]).per(params[:per])
    end

    def guest
      @activities = PublicActivity::Activity.order(created_at: :desc).page(params[:page]).per(params[:per])
    end
  end
end
