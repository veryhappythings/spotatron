class FriendsController < ApplicationController
  before_filter :get_info
  
  private
    def get_info
        if logged_in?
          @spots = Spot.from_friends_of current_user
        else
          @spots = []
        end
    end
end
