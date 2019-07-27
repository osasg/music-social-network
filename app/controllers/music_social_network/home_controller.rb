module MusicSocialNetwork
  class HomeController < ApplicationController
    def index
      @activities = []

      return unless current_user.present?
      
      public_activities = PublicActivity::Activity.all
      public_activities.each do |activity|
        if activity.owner.followed_by? current_user
          @activities << activity
        end
      end
    end

  end
end
