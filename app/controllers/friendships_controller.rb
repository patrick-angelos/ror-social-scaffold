class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    @friendship.status = false

    if @friendship.save
      redirect_to @friendship.friend, notice: 'Invitation Sent'
    else
      redirect_to @friendship.friend, alert: 'Invitaion was not sent'
    end
  end
end
