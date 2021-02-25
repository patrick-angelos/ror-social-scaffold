class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.confirmed_friends(user)
    sent_friendships = Friendship.all.where(user_id: user.id, status: true)
    received_friendships = Friendship.all.where(friend_id: user.id, status: true)
    all_friends = sent_friendships.map { |friendship| friendship.friend.id }
    all_friends + received_friendships.map { |friendship| friendship.user.id }
  end

  def self.pending_requests(user)
    Friendship.all.where(friend_id: user.id, status: false)
  end

  def self.all_friends(user)
    sent_friendships = Friendship.all.where(user_id: user.id)
    received_friendships = Friendship.all.where(friend_id: user.id)
    all_friends = sent_friendships.map { |friendship| friendship.friend.id }
    all_friends + received_friendships.map { |friendship| friendship.user.id }
  end
end
