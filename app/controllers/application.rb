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
      if logged_in?
        @spots = current_user.friends.inject([]) { |spots, f| spots.concat f.spots }.concat current_user.spots
      else
        @spots = Spot.find(:all)
      end
    end
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
