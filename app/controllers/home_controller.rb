class HomeController < ApplicationController
  def index
    @spot = Spot.new
  end
end
