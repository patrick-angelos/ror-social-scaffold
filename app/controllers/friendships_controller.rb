class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    @friendship.status = false

    if @friendship.save
      redirect_to session[:redirect_url], notice: 'Invitation Sent'
    else
      redirect_to session[:redirect_url], alert: 'Invitaion was not sent'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.status = true
    @friendship.save
    @inverse_friendship = Friendship.new(user_id: current_user.id, friend_id: @friendship.user_id, status: true)
    @inverse_friendship.save
    redirect_to session[:redirect_url], notice: 'Invitation Accepted'
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to session[:redirect_url], notice: 'Invitation Rejected'
  end
end
