# frozen_string_literal: true

# commencement date migration
class ChangeDefaultCommencementDate < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :commencement_date, -> { 'CURRENT_TIMESTAMP' }
  end
end
