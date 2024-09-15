# frozen_string_literal: true

class VacationRequest < ApplicationRecord
  validates :start_date, :end_date, presence: true
  validate :start_date_in_the_future
  validate :start_date_before_end_date

  enum status: {
    pending: 0,
    accepted: 1,
    declined: 2
  }, _default: 0

  belongs_to :employee

  private

  def start_date_in_the_future
    return if start_date.blank?

    return unless start_date < Date.today

    errors.add(:start_date, 'must be in the future')
  end

  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    return unless start_date >= end_date

    errors.add(:start_date, 'must be before the end date')
  end
end
