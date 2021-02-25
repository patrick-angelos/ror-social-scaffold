class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.confirmed_friends(user)
    friendships = Friendship.all.where(user_id: user.id, status: 2)
    friendships.map { |friendship| friendship.friend.id }
  end

  def self.pending_requests(user)
    Friendship.all.where(friend_id: user.id, status: 1)
  end

  def self.all_friends(user)
    friendships = Friendship.all.where(user_id: user.id)
    friendships.map { |friendship| friendship.friend.id }
  end
end
