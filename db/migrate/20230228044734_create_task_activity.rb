# frozen_string_literal: true

# task activity migration
class CreateTaskActivity < ActiveRecord::Migration[6.0]
  def change
    create_table :task_activities do |t|
      t.references :task
      t.string :from
      t.string :to
      t.timestamps
    end
  end
end
