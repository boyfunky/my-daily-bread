# frozen_string_literal: true

# Task Activity model
class TaskActivity < ApplicationRecord
  belongs_to :task
end
