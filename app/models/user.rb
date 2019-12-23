class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :stops, through: :trips, source: :listing
  has_many :hosts, through: :stops
  has_many :reviews, :foreign_key => 'guest_id'
  
  has_many :reservations, :through => :listings
  has_many :guests, through: :listings
  has_many :host_reviews, through: :listings, source: :reviews
  

  def update_host_status
    self.listings.count > 0 ? self.host = true : self.host = false
    self.save
  end

end
