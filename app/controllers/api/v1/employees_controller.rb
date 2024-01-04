class Api::V1::EmployeesController < ApplicationController
  include EmployeeConcern 

  # POST /api/v1/employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: {employee: @employee, status: 200, message: "Employee created successfully."}
    else
      render json: {employee: @employee, message: @employee.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/employees/tax_deduction
  def tax_deduction
    employees_tax_data = []

    Employee.find_in_batches(batch_size: 50) do |group_of_employees|
      group_of_employees.each do |employee|
        employees_tax_data << calculate_tax_deduction(employee)
      end
    end

    render json: employees_tax_data
  end

  private

  def employee_params
    params.require(:employee).permit(:employee_id, :first_name, :last_name, :email, :doj, :salary, phone_numbers: [])
  end
end
