# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :task_activities
  enumerize :status, in: %i[backlog in_progress delayed completed], default: :backlog

  after_commit :create_task_activity, if: proc { |record| record.previous_changes.key?(:status) }

  private

  def create_task_activity
    task_activities.create({ from: previous_changes['status'].first, to: status })
  end
end
