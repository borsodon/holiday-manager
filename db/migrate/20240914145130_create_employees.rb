# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_id, null: false
      t.string :name, null: false
      t.datetime :date_of_birth, null: false

      t.timestamps
    end
  end
end
