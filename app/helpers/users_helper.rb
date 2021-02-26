module UsersHelper
  def current_user_profile(user)
    user.id == current_user.id
  end

  def invite_link(user)
    if current_user.pending_sent_friends.exists?(user.id)
      text = ''
      text << (content_tag :p, 'Invitation sent')
      text.html_safe
    elsif current_user.pending_friends.exists?(user.id)
      request = current_user.request_from(user)
      text = ''
      accept = (content_tag :span, (link_to ' Accept ', "/users/#{user.id}/friendships/#{request.id}", method: :put))
      reject = (content_tag :sapn, (link_to ' Reject', "/users/#{user.id}/friendships/#{request.id}", method: :delete))
      text << (content_tag :p, accept + reject)
      text.html_safe
    elsif !current_user.friends.exists?(user.id) && !current_user_profile(user)
      link_to 'Invite', "/users/#{user.id}/friendships", method: :post
    end
  end

  def friend_requests(user)
    invitations = ''
    if current_user_profile(user)
      invitations << (content_tag :p, 'Invitations:')
      user.pending_friendships.each do |friendship|
        name = (content_tag :span, friendship.user.name)
        accept = (content_tag :span,
                              (link_to ' Accept ', "/users/#{user.id}/friendships/#{friendship.id}", method: :put))
        reject = (content_tag :sapn,
                              (link_to ' Reject', "/users/#{user.id}/friendships/#{friendship.id}", method: :delete))
        invitations << (content_tag :p, name + accept + reject)
      end
    end
    invitations.html_safe
  end
end
