class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @apot = Spot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spot }
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user == nil
      @user = User.find_by_login(params[:login])
    end
    @spots = Spot.find(:all, :conditions => ["user_id = ?", @user.id])
    if logged_in? && current_user.friends.include?(@user)
      @friendship = Friendship.find(:first, :conditions => "user_id = #{current_user.id} AND friend_id = #{@user.id}")
    else
      @friendship = Friendship.new
    end
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end
end
