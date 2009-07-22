class Spot < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :tags
  
  validates_format_of :url, :with => /\Ahttp:\/\/open\.spotify\.com\/.*/, :message => 'URL is not valid'
  
  #default_scope :order => 'created_at ASC'
  # SELECT * FROM spots WHERE spots.user_id IN (SELECT friend_id FROM friendships WHERE user_id = ?)
  # SELECT * FROM spots
  named_scope :from_friends_of, lambda { |user| {:conditions => {:user_id => user.friends}}}
  
  def uri
    # Naievly convert 1 into 2
    # 1: http://open.spotify.com/track/5ibnia6j39WwM17OfP7zR1
    # 2: spotify:track:5ibnia6j39WwM17OfP7zR1

    self.url.sub('http://open.spotify.com/','spotify:').gsub('/',':')
  end
end
