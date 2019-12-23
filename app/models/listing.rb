class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :address, :listing_type, :title, :description, :price, :neighborhood, :host, presence: true

  after_create {self.host.update_host_status}

  after_destroy {self.host.update_host_status}

  def average_review_rating
    total = self.reviews.sum {|r| r.rating}
    total.to_f / self.reviews.count
  end

end
