class Friendship < ApplicationRecord
  belongs_to :friend_request, class_name: "User", foreign_key: :user_id
  belongs_to :friend, class_name: "User"

  scope :pending, ->{where('STATUS = false')}
  scope :confirmed, ->{where('STATUS = true')}

  def self.pending_friends(user)
    user.friendships.map {|friendship| friendship.friend if friendship.status == false}
  end

  def self.confirmed_friends(user)
    user.friendships.map {|friendship| friendship.friend if friendship.status == true}
  end

  def self.pending_requests(user)
    received_friendships = Friendship.all.where(friend_id: user.id)
    pending_friends = received_friendships.map {|friendship| friendship.friend_request}
  end

  def self.all_friends(user)
    sent_friendships = Friendship.all.where(user_id: user.id)
    received_friendships = Friendship.all.where(friend_id: user.id)
    all_friends = sent_friendships.map {|friendship| friendship.friend}
    all_friends += received_friendships.map {|friendship| friendship.friend_request}
  end
end
