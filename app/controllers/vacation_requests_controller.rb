# frozen_string_literal: true

# app/controllers/vacation_requests_controller.rb
class VacationRequestsController < ApplicationController
  before_action :load_request, only: %i[accept decline]

  def index
    if params[:employee_id]
      @employee = Employee.find(params[:employee_id])
      vacation_requests_array = @employee.vacation_requests.to_a # Convert to array
      @requests = Kaminari.paginate_array(vacation_requests_array).page(params[:page]).per(10)
    else
      @requests = VacationRequest.page(params[:page]).per(10)
    end
  end

  def new
    @employee = Employee.find(params[:employee_id])
    @request = @employee.vacation_requests.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @request = @employee.vacation_requests.build(vacation_request_params)

    if @request.save
      redirect_to employee_vacation_requests_path(@employee.id), notice: 'Vacation request created successfully.'
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('vacation_form', partial: 'vacation_requests/form',
                                                                     locals: { employee: @employee, request: @request })
        end
      end
    end
  end

  def accept
    if @request.accepted!
      redirect_to employee_vacation_requests_path(@request.employee), notice: 'Vacation request accepted.'
    else
      redirect_to employee_vacation_requests_path(@request.employee), alert: 'Failed to accept the vacation request.'
    end
  end

  def decline
    if @request.declined!
      redirect_to employee_vacation_requests_path(@request.employee), notice: 'Vacation request declined.'
    else
      redirect_to employee_vacation_requests_path(@request.employee), alert: 'Failed to decline the vacation request.'
    end
  end

  private

  def load_request
    @request = VacationRequest.find_by(id: params[:id])
  end

  def vacation_request_params
    params.require(:vacation_request).permit(:start_date, :end_date)
  end
end
