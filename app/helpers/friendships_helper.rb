module FriendshipsHelper
  def friend?(user)
    Friendship.all_friends(current_user).any?(user)
  end
end
