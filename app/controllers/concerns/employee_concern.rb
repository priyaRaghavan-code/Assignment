module EmployeeConcern
  def calculate_tax_deduction(employee)
    monthly_salary = employee.salary
    total_salary = calculate_total_salary(employee.doj, monthly_salary)
    tax_amount = calculate_tax(total_salary)
    cess_amount = calculate_cess(total_salary)
    yearly_salary = monthly_salary * 12
    loss_of_pay_per_day = calculate_loss_of_pay_per_day(monthly_salary)

    {
      employee_code: employee.employee_id,
      first_name: employee.first_name,
      last_name: employee.last_name,
      yearly_salary: yearly_salary,
      tax_amount: tax_amount,
      loss_of_pay_per_day: loss_of_pay_per_day,
      cess_amount: cess_amount,
    }
  end

  def calculate_total_salary(date_of_joining, monthly_salary)
    financial_year_start = Date.new(2023, 4, 1)
    financial_year_end = Date.new(2024, 3, 31)

    start_date = [date_of_joining, financial_year_start].max
    end_date = [Date.today, financial_year_end].min

    total_months = if start_date.year == end_date.year
                     end_date.month - start_date.month + 1
                   else
                     (12 - start_date.month + 1) + (end_date.year - start_date.year - 1) * 12 + end_date.month
                   end
    total_salary = total_months * monthly_salary
  end

  def calculate_tax(total_salary)
    case
    when total_salary <= 250000
      0
    when total_salary <= 500000
      (total_salary - 250000) * 0.05
    when total_salary <= 750000
      puts total_salary
      12500 + ((total_salary - 500000) * 0.1)
    else
      37500 + ((total_salary - 750000) * 0.2)
    end
  end

  def calculate_cess(total_salary)
    taxable_amount = [total_salary - 2500000, 0].max
    cess_percentage = taxable_amount.positive? ? 0.02 : 0
    cess_amount = taxable_amount * cess_percentage
  end

  def calculate_loss_of_pay_per_day(monthly_salary)
    days_in_month = 30
    loss_of_pay_per_day = monthly_salary / days_in_month.to_f
  end
end
