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

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.status = true
    @friendship.save
    @inverse_friendship = Friendship.new(user_id: current_user.id, friend_id: @friendship.user_id, status: true)
    @inverse_friendship.save
    redirect_to current_user, notice: 'Invitation Accepted'
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to current_user, notice: 'Invitation Rejected'
  end
end
