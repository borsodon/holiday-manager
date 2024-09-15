# frozen_string_literal: true

class SyncLog < ApplicationRecord
  validates :last_sync_at, presence: true
  validates :entity, presence: true
end
