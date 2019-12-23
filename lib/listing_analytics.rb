require 'date_helper'

module ListingAnalytics

    module InstanceMethods
        include DateHelper

        def listings_open_within(start_date, end_date)
            open_listings = []
            range_start = Date.strptime(start_date)
            range_end = Date.strptime(end_date)
        
            self.listings.each do |listing|
              available = true
        
              listing.reservations.each do |r|
                if date_ranges_conflict?(range_start, range_end, r.checkin, r.checkout)
                  available = false
                  break
                end
              end
        
              open_listings << listing if available
            end
            open_listings
          end
    end

    module ClassMethods

        def highest_ratio_res_to_listings
            most_listings = self.all.first
            locus_listings_info = {}
            locus_listings_info[most_listings] = 0
            self.all.each do |locus|
                next if locus.listings.count == 0
                total_reservations = 0
                total_listings = locus.listings.count
             
        
                locus.listings.each {|l| total_reservations += l.reservations.count}
            
                ratio = total_reservations / total_listings
            
                locus_listings_info[locus] = ratio
            
                most_listings = locus if ratio > locus_listings_info[most_listings]
        
            end
            most_listings
          end
        
          def most_res
            most_res = self.all.first
            res_hash = {}
            res_hash[most_res] = 0
        
            self.all.each do |locus|
              total_res = 0
        
              locus.listings.each {|l| total_res += l.reservations.count}
        
              res_hash[locus] = total_res
        
              most_res = locus if total_res > res_hash[most_res]
            end
            most_res
          end

    end  
end