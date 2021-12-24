################################################################################
# Model:  Appointment
#
# Joined Model with its own attributes:
#
# Appointment attributes:
#   doctor_id        - FK
#   patient_id       - FK
#   appointment_date - datetime
#
#  23.12.2021 ZT
################################################################################
class Appointment < ApplicationRecord
  belongs_to :doctor, required: true
  belongs_to :patient, required: true
  accepts_nested_attributes_for :doctor

  validates :doctor,  presence: true
  validates :patient, presence: true
end
