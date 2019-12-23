require 'date_helper'

class DatesValidator < ActiveModel::Validator
    include DateHelper

    def validate(record)

        if record.checkin.nil? || record.checkout.nil?
            record.errors[:checkin] << "Must have a checkin" if record.checkin.nil?
            record.errors[:checkout] << "Must have a checkout" if record.checkout.nil?
            return
        end

        if date_greater_than_other?(record.checkin, record.checkout)
            # puts "Reservation invalid!"
            record.errors[:checkin] << "Must be less than checkout"
            record.errors[:checkout] << "Must be greater than checkin"
            return
        end

        if (record.checkin <=> record.checkout) == 0
            record.errors[:checkin] << "Checkin must not equal checkout"
            record.errors[:checkout] << "Checkout must not equal checkin"
            return
        end

        record.listing.reservations.each do |reservation|
            if date_ranges_conflict?(reservation.checkin, reservation.checkout, record.checkin, record.checkout)
                record.errors[:checkin] << 'These dates conflict with another reservation'
                record.errors[:checkout] << 'These dates conflict with another reservation'
                break
            end

        end
    end
end