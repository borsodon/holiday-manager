# frozen_string_literal: true

class AddDepartmentsToVacationRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :department_id, :integer
    add_foreign_key :employees, :departments
    add_index :employees, :department_id
  end
end
