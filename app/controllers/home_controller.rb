class HomeController < ApplicationController
  def index
    @activities = []
    
    public_activities = PublicActivity::Activity.all
    public_activities.each do |activity|
      if activity.owner.followed_by? current_user
        @activities << activity
      end
    end
  end
end
