################################################################################
# Model:  Appointment
#
# Purpose:
#
# Appointment attributes:
#   doctor_id          - FK
#   patient_id          - FK
#   appointment_date             - appointment_date:  datetime
#
#  23.12.2021 ZT
################################################################################
class Appointment < ApplicationRecord
  belongs_to :doctor, required: true
  belongs_to :patient, required: true

  validates :doctor, presence: true
  validates :patient, presence: true
end
