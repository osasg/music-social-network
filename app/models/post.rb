class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :attachment, AvatarUploader

  acts_as_votable
  acts_as_commentable
end
