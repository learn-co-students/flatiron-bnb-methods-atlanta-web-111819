class ReservationValidator < ActiveModel::Validator
    def validate(record)
        return if record.reservation.nil?
        unless (Time.now <=> record.reservation.checkout) > 0
            record.errors[:reservation_id] << 'the associated reservation has not been completed'
        end
    end
end