class Friendship < ApplicationRecord
  # belongs_to :user
  belongs_to :friend_request, class_name: "User", foreign_key: :user_id
  belongs_to :friend, class_name: "User"
end
