class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :attachment, AvatarUploader

  include PublicActivity::Model

  tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

  acts_as_votable
  acts_as_commentable
end
