# require 'date_helper'
require 'listing_analytics'

class City < ActiveRecord::Base
  # include DateHelper
  include ListingAnalytics::InstanceMethods
  extend ListingAnalytics::ClassMethods

  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
    listings_open_within(start_date, end_date)
  end

end

