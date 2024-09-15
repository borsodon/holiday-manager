# frozen_string_literal: true

class CreateSyncLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :sync_logs do |t|
      t.string :entity
      t.datetime :last_sync_at

      t.timestamps
    end
  end
end
