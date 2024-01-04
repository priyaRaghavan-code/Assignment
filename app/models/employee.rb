class Employee < ApplicationRecord
  serialize :phone_numbers, Array

  # ===== Validations =======
  validates :employee_id, :doj, :salary, :phone_numbers, presence: true
  validates :employee_id, uniqueness: true
  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "should contain only alphabets" }
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }, uniqueness: true
  validates :salary, numericality: { greater_than: 0 }

  # Custom validation for phone numbers
  validate :validate_phone_numbers

  private

  def validate_phone_numbers
    if phone_numbers.present? && phone_numbers.any? { |num| !valid_indian_number?(num) }
      errors.add(:phone_numbers, "should contain only 10-digit Indian numbers")
    end
  end

  def valid_indian_number?(number)
    /^(?:\+91)?[789]\d{9}$/ === number.to_s
  end
  
end
