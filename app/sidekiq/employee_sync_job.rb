# frozen_string_literal: true

class EmployeeSyncJob
  include Sidekiq::Worker

  def perform(*_args)
    EmployeeSynchronizer.new.sync
  end
end
