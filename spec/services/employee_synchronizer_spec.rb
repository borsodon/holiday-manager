# frozen_string_literal: true

require 'rspec_helper'

RSpec.describe 'EmployeeSynchronizer', type: :service do
  let(:api_client) { instance_double(EmployeeApiClient) }
  let(:synchronizer) { EmployeeSynchronizer.new(api_client) }
  let(:employee_data) do
    [
      {
        'employee_id' => 'E001',
        'name' => 'John Doe',
        'date_of_birth' => '1985-03-15',
        'department' => 'Engineering'
      },
      {
        'employee_id' => 'E002',
        'name' => 'Jane Smith',
        'date_of_birth' => '1990-07-22',
        'department' => 'Marketing'
      }
    ]
  end

  before do
    allow(api_client).to receive(:fetch_employees).and_return(employee_data)
  end

  context 'when there are no previous sync logs' do
    it 'creates departments and employees from the API response' do
      expect { synchronizer.sync }.to change { Department.count }.by(2)
                                                                 .and change { Employee.count }.by(2)

      expect(Department.pluck(:name)).to include('Engineering', 'Marketing')

      expect(Employee.pluck(:employee_id)).to include('E001', 'E002')
      expect(Employee.pluck(:name)).to include('John Doe', 'Jane Smith')
    end

    it 'logs the sync time' do
      expect { synchronizer.sync }.to change { SyncLog.count }.by(1)
    end
  end

  context 'when employees already exist' do
    before do
      department = Department.create!(name: 'Engineering')
      Employee.create!(employee_id: 'E001', name: 'Old Name', date_of_birth: '1985-03-15', department: department)
    end

    it 'updates existing employees with new data' do
      expect { synchronizer.sync }.not_to(change { Employee.count })

      updated_employee = Employee.find_by(employee_id: 'E001')
      expect(updated_employee.name).to eq('John Doe') # Ensure it updated the name
    end
  end
end
