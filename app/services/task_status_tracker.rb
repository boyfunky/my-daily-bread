# frozen_string_literal: true

# Task Status Tracker
class TaskStatusTracker
  def initialize(task_id)
    @task = Task.find(task_id)
    @status_duration = {}
    @status_values = Task.status.values
  end

  def call
    @status_values.each do |status|
      duration = 0
      activities = @task.task_activities
      activities.where(to: status).each do |activity|
        status_date = activity.created_at
        moved_from_status_date = moved_from_status_date(activities, status, status_date)
        duration += TimeDifference.between(moved_from_status_date, status_date).in_seconds
      end
      @status_duration = @status_duration.merge({ status.to_sym => seconds_to_str(duration.ceil) })
    end
    @status_duration.reject { |k, v| v.empty? }
  end

  def moved_from_status_date(activities, status, status_date)
    activities.where(from: status).find_by('created_at > ?', status_date).try(:created_at) || DateTime.now
  end

  def seconds_to_str(seconds)
    ["#{seconds / 3600}h", "#{seconds / 60 % 60}m", "#{seconds % 60}s"]
      .select { |str| str =~ /[1-9]/ }.join(' ')
  end
end
