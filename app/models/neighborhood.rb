require 'listing_analytics'

class Neighborhood < ActiveRecord::Base
  include ListingAnalytics::InstanceMethods
  extend ListingAnalytics::ClassMethods
  
  belongs_to :city
  has_many :listings

  def neighborhood_openings(start_date, end_date)
    listings_open_within(start_date, end_date)
  end

end
