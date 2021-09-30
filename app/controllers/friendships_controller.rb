class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user])
    current_user.friendships.build(friend_id: user.id)
    if current_user.save
      flash[:notice] = "#{user.first_name} followed"
      redirect_to my_friends_path
    end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "friend unfollowed"
    redirect_to my_friends_path
  end
end
