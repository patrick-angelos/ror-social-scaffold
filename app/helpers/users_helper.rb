module UsersHelper
  def current_user_profile(user)
    user.id == current_user.id
  end

  def invite_link(user)
    if !friend?(user) && !current_user_profile(user)
      link_to "Invite", "/users/#{user.id}/friendships", method: :post
    end
  end

  def friend_requests(user)
    invitations = ''
    if current_user_profile(user)
      invitations << (content_tag :p, 'Invitations:')
      Friendship.pending_requests(user).each do |friendship|
        name = (content_tag :span, friendship.inverse_friend.name)
        accept =  (content_tag :span, (link_to ' Accept ', friendship_path(friendship), method: :put))
        reject =  (content_tag :sapn, (link_to ' Reject', friendship_path(friendship), method: :delete))
        invitations << (content_tag :p, name + accept + reject)
      end
    end
    invitations.html_safe
  end
end

# <li><%= friendship.friend_request.name %> <%= link_to 'Accept', "/users/#{@user.id}/friendships/#{friendship.id}", method: :put%> <%= link_to 'Reject', "/users/#{@user.id}/friendships/#{friendship.id}", method: :delete %></li>