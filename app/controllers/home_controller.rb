class HomeController < ApplicationController
  def index
    @spot = Spot.new
    if logged_in?
      @spot.tag_list << current_user.login
    end
  end
end
