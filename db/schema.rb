# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_240_914_182_210) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'departments', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_departments_on_name', unique: true
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'employee_id', null: false
    t.string 'name', null: false
    t.datetime 'date_of_birth', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'department_id'
    t.index ['department_id'], name: 'index_employees_on_department_id'
    t.index ['employee_id'], name: 'index_employees_on_employee_id', unique: true
  end

  create_table 'sync_logs', force: :cascade do |t|
    t.string 'entity'
    t.datetime 'last_sync_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'vacation_requests', force: :cascade do |t|
    t.datetime 'start_date', null: false
    t.datetime 'end_date', null: false
    t.bigint 'employee_id', null: false
    t.integer 'status', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['employee_id'], name: 'index_vacation_requests_on_employee_id'
  end

  add_foreign_key 'employees', 'departments'
  add_foreign_key 'vacation_requests', 'employees'
end
