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
    @pair_friendship = Friendship.all.where("id >= ?", params[:id]).limit(2)
    @pair_friendship.each do |friendship| 
      friendship.status = 2
      friendship.save
    end
    redirect_to current_user, notice: 'Invitation Accepted'
  end

  def destroy
    @pair_friendship = Friendship.all.where("id >= ?", params[:id]).limit(2)
    @pair_friendship.each do |friendship| 
      friendship.destroy
    end
    redirect_to current_user, notice: 'Invitation Rejected'
  end
end
