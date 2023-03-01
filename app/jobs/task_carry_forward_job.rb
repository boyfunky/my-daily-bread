# frozen_string_literal: true

#  Carry Forward Task Worker
class TaskCarryForwardJob < ApplicationJob
  def perform
    prev_day = DateTime.now.prev_day
    tasks = Task.where.not(status: :completed).where(commencement_date: prev_day.beginning_of_day..prev_day.end_of_day)
    tasks.update_all(commencement_date: DateTime.now)
  end
end
