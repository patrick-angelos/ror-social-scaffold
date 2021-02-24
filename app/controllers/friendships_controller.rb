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
    if @friendship.save
      redirect_to current_user, notice: 'Invitation Accepted'
    else
      redirect_to current_user, alert: 'Something went wrong'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to current_user
  end
end
