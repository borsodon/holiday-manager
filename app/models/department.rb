# frozen_string_literal: true

class Department < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :employees, dependent: :destroy
end
