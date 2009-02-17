class SpotsController < ApplicationController
  def show
    @spot = Spot.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  # POST /spots
  # POST /spots.xml
  def create
    if not logged_in?
      flash[:notice] = 'You have to log in before you can post!'
      redirect_back_or_default('/')
      return
    end
    params[:spot][:url].gsub!('spotify:','http://open.spotify.com/')
    params[:spot][:url].gsub!(/:([^\/])/,'/\1')
    @spot = Spot.new(params[:spot])
    @spot.user_id = current_user.id

    if @spot.save
      flash[:notice] = 'spot was successfully created.'
      redirect_back_or_default('/')
    else
      redirect_back_or_default('/')
    end
  end
  
  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy

    redirect_back_or_default('/')
  end
  
end
