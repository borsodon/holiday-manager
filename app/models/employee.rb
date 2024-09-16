# frozen_string_literal: true

class Employee < ApplicationRecord
  validates :employee_id, presence: true, uniqueness: true
  validates :name, :date_of_birth, presence: true

  has_many :vacation_requests, dependent: :destroy
  belongs_to :department
end
