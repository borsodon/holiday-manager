# frozen_string_literal: true

class AddUniqueIndexToEmployeesEmployeeId < ActiveRecord::Migration[7.0]
  def change
    add_index :employees, :employee_id, unique: true
  end
end
