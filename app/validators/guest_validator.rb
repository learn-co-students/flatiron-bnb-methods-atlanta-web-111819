class GuestValidator < ActiveModel::Validator
    def validate(record)
        # byebug
        if record.guest_id == record.listing.host_id
            record.errors[:guest] << "The host cannot be a guest at his own listing"
        end
    end
end