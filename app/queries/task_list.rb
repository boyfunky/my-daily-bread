# frozen_string_literal: true

# Task Query Object
class TaskList
  # module for filters
  module Scopes
    def by_status(status)
      return self if status.blank?

      where(status: status)
    end

    def by_title(title)
      return self if title.blank?

      where('title LIKE ?', "%#{title}%")
    end

    def by_date(date)
      date_range = date.beginning_of_day..date.end_of_day
      where(commencement_date: date_range)
    end
  end

  def self.call(filters, user)
    user.tasks
        .extending(Scopes)
        .by_status(filters[:status])
        .by_title(filters[:title])
        .by_date(filters[:date] || DateTime.now)
  end
end
