# frozen_string_literal: true

# Task migration
class CreateTask < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user
      t.string :status
      t.string :title
      t.text :description
      t.datetime :commencement_date
      t.timestamps
    end
  end
end
