class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    @inverse_friendship = Friendship.new(user_id: params[:user_id], friend_id: current_user.id, status: 0)
    @friendship.status = 1

    if @friendship.save && @inverse_friendship.save
      redirect_to @friendship.friend, notice: 'Invitation Sent'
    else
      redirect_to @friendship.friend, alert: 'Invitaion was not sent'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @inverse_friendship = Friendship.find(params[:id].to_i + 1)
    @friendship.status = 2
    @inverse_friendship.status = 2
    if @friendship.save && @inverse_friendship.save
      redirect_to current_user, notice: 'Invitation Accepted'
    else
      redirect_to current_user, alert: 'Something went wrong'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @inverse_friendship = Friendship.find(params[:id].to_i + 1)
    @friendship.destroy
    @inverse_friendship.destroy
    redirect_to current_user, notice: 'Invitation Rejected'
  end
end
