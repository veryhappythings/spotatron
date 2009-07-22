# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '600a87c30849d2246bad3bfdb341b23d'
  
  before_filter :get_info
  
  private
    def get_info
        @spots = Spot.find(:all)
        if logged_in?
          # TODO : make User a tagger and get the tags that the user makes.
          @tags = Spot.find(:all, :conditions => ["user_id = ?", current_user.id]).map {|spot| spot.tag_list}.flatten!
          @tags = @tags.uniq - [current_user.login]
        else
          @tags = []
        end
    end
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
