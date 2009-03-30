class FriendshipsController < ApplicationController
  def create
    current_user.friendships.create(:friend => User.find_by_id(params[:user][:id]))
    current_user.save!
    redirect_back_or_default(url_for(User.find_by_id(params[:user][:id])))
  end

  def destroy
    Friendship.delete params[:id]
    redirect_back_or_default(url_for(User.find_by_id(params[:user][:id])))
  end
end
