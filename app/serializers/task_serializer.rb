# frozen_string_literal: true

# task serializer
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :commencement_date, :status_audit_trail

  def status_audit_trail
    TaskStatusTracker.new(object.id).call
  end
end
