class SpotsController < ApplicationController
  def index
    if params[:search]
      if params[:mine]
        @spots = Spot.find_all_by_user_id(@current_user.id).reject! {|spot| !spot.tag_list.include? params[:search]}
      else
        @spots = Spot.tagged_with(params[:search], :on => :tags)
      end
    else
      @spots = []
    end
  end

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
    #spotify_uri = params[:spot][:url].split(':')
    #spotify_uri[0] = 'http://open.spotify.com'
    #spotify_uri.join('/')

    params[:spot][:url].gsub!('spotify:','http://open.spotify.com/')
    params[:spot][:url].gsub!(/:([^\/])/,'/\1')
    @spot = Spot.new(params[:spot])
    @spot.user_id = current_user.id

    case @spot.url
      when /track/
        @spot.tag_list << 'track'
      when /album/
        @spot.tag_list << 'album'
      when /artist/
        @spot.tag_list << 'artist'
      when /playlist/
        @spot.tag_list << 'playlist'
      when /search/
        @spot.tag_list << 'search'
    end

    @current_user.tag(@spot, :with => @spot.tag_list, :on => :tags)

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

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])

    respond_to do |format|
      if @spot.update_attributes(params[:spot])
        flash[:notice] = 'Spot was successfully updated.'
        format.html { redirect_to(@spot) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spot.errors, :status => :unprocessable_entity }
      end
    end
  end
end
