# frozen_string_literal: true

class CreateVacationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :vacation_requests do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :employee, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
