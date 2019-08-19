module MusicSocialNetwork
  class LikeChannel < ApplicationCable::Channel
    def subscribed
      stream_from "#{params[:stream]}-#{params[:likeable_id]}"
    end
  end
end
