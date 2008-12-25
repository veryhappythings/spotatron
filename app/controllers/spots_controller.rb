class SpotsController < ApplicationController
  # POST /spots
  # POST /spots.xml
  def create
    if not logged_in?
      flash[:notice] = 'You have to log in before you can post!'
      redirect_back_or_default('/')
      return
    end
    
    @spot = Spot.new(params[:spot])
    @spot.user_id = current_user.id
    if @spot.save
      flash[:notice] = 'spot was successfully created.'
      redirect_back_or_default('/')
    else
      redirect_back_or_default('/')
    end
  end
end
