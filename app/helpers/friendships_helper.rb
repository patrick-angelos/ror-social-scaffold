module FriendshipsHelper
  def friend?(user)
    current_user.friends.exists?(user.id) || current_user.pending_friends.exists?(user.id)
  end

  def friendship_path(friendship)
    "/users/#{@user.id}/friendships/#{friendship.id}"
  end
end
