class HomeController < ApplicationController
  def index
    @spot = Spot.new

    @spots = Spot.paginate(:page => params[:page])

    if logged_in?
      @tags = @current_user.owned_tags
    else
      @tags = []
    end
  end
end
