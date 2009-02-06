class Spot < ActiveRecord::Base
  belongs_to :user
  
  validates_format_of :url, :with => /\Ahttp:\/\/open\.spotify\.com\/.*/, :message => 'URL is not valid'

  def uri
    # Naievly convert 1 into 2
    # 1: http://open.spotify.com/track/5ibnia6j39WwM17OfP7zR1
    # 2: spotify:track:5ibnia6j39WwM17OfP7zR1
    
    self.url.sub('http://open.spotify.com/','spotify:').sub('/',':')
  end
end
