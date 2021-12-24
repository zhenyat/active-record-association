################################################################################
# Model:  Patient
#
# Patient attributes:
#   name  - string,  not NULL, unique
#
#  23.12.2021 ZT
################################################################################
class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments
  accepts_nested_attributes_for :appointments

  validates :name,  presence: true, uniqueness: true
end
