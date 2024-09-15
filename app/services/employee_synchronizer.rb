# frozen_string_literal: true

class EmployeeSynchronizer
  def initialize(api_client = EmployeeApiClient.new)
    @api_client = api_client
  end

  def sync
    last_sync_time = fetch_last_sync_time
    employees_from_api = fetch_employees(last_sync_time)

    return if employees_from_api.blank?

    ActiveRecord::Base.transaction do
      department_import(employees_from_api)
      employee_import(employees_from_api)

      SyncLog.create!(entity: 'employees', last_sync_at: Time.current)
    end
  rescue StandardError => e
    Rails.logger.error("Employee sync failed: #{e.message}")
  end

  private

  def fetch_last_sync_time
    SyncLog.where(entity: 'employees').order(created_at: :desc).pluck(:last_sync_at).first
  end

  def fetch_employees(last_sync_time)
    @api_client.fetch_employees(last_sync_time)
  end

  def department_import(employees_data)
    departments = employees_data.map do |employee_data|
      Department.new(
        name: employee_data['department']
      )
    end

    Department.import(departments, on_duplicate_key_update: { conflict_target: [:name], columns: [:updated_at] })
  end

  def employee_import(employees_data)
    employees = employees_data.map do |employee_data|
      department = Department.find_by(name: employee_data['department'])

      Employee.new(
        employee_id: employee_data['employee_id'],
        name: employee_data['name'],
        date_of_birth: employee_data['date_of_birth'],
        department_id: department&.id # Ensure department exists before using the ID
      )
    end

    Employee.import(employees,
                    on_duplicate_key_update: { conflict_target: [:employee_id],
                                               columns: %i[name date_of_birth department_id] })
  end
end
