class Spot < ActiveRecord::Base
  belongs_to :user
  
  validates_format_of :url, :with => /\Ahttp:\/\/open\.spotify\.com\/.*/, :message => 'URL is not valid'
end
