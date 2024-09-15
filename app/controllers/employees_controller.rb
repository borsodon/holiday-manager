# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :load_employees, only: %i[index]

  def index; end

  private

  def load_employees
    @employees = Employee.page(params[:page]).per(4)
  end
end
