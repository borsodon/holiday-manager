# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-cron'

# Sidekiq::Cron::Job.create(
#   name: 'Employee sync - every day at midnight',
#   cron: '0 0 * * *',
#   class: 'EmployeeSyncJob'
# )
