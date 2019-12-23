module DateHelper
    def date_less_than_other?(date, other_date)
        (date <=> other_date) < 0
    end

    def date_greater_than_other?(date, other_date)
        (date <=> other_date) > 0
    end

    def date_within_range?(range_start, range_end, test_date)
        date_greater_than_other?(test_date, range_start) && date_less_than_other?(test_date, range_end)
    end

    def dates_encompass_range?(first_date, second_date, range_start, range_end)
        date_less_than_other?(first_date, range_start) && date_greater_than_other?(second_date, range_end)
    end

    def dates_overlap?(first_range_start, first_range_end, second_range_start, second_range_end)
        date_within_range?(first_range_start, first_range_end, second_range_start) ||
        date_within_range?(first_range_start, first_range_end, second_range_end)
    end

    def date_ranges_conflict?(date_range_start, date_range_end, test_dates_start, test_dates_end)
        dates_overlap?(date_range_start, date_range_end, test_dates_start, test_dates_end) ||
        dates_encompass_range?(test_dates_start, test_dates_end, date_range_start, date_range_end)
    end
end