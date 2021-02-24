class Friendship < ApplicationRecord
  belongs_to :inverse_friend, class_name: "User", foreign_key: :user_id
  belongs_to :friend, class_name: "User"

  # scope :pending, ->{where('STATUS = false')}
  # scope :confirmed, ->{where('STATUS = true')}

  def self.confirmed_friends(user)
    sent_friendships = Friendship.all.where(user_id: user.id, status: true)
    received_friendships = Friendship.all.where(friend_id: user.id, status: true)
    all_friends = sent_friendships.map {|friendship| friendship.friend.id}
    all_friends += received_friendships.map {|friendship| friendship.inverse_friend.id}
  end

  def self.pending_requests(user)
    received_friendships = Friendship.all.where(friend_id: user.id, status: false)
  end

  def self.all_friends(user)
    sent_friendships = Friendship.all.where(user_id: user.id)
    received_friendships = Friendship.all.where(friend_id: user.id)
    all_friends = sent_friendships.map {|friendship| friendship.friend.id}
    all_friends += received_friendships.map {|friendship| friendship.inverse_friend.id}
  end
end
