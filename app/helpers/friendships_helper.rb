module FriendshipsHelper
  def friend?(user)
    Friendship.all_friends(current_user).any?(user.id)
  end

  def friendship_path(friendship)
    "/users/#{@user.id}/friendships/#{friendship.id}"
  end
end
