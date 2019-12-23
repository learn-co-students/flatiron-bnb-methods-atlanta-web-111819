class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates_with GuestValidator
  validates_with DatesValidator

  def duration
    self.checkout - self.checkin
  end

  def total_price
    self.duration * self.listing.price
  end

end
