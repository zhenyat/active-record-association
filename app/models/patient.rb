################################################################################
# Model:  Patient
#
# Purpose:
#
# Patient attributes:
#   name              - name:           string,  not NULL, unique
#
#  23.12.2021 ZT
################################################################################
class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments

  validates :name,  presence: true, uniqueness: true
end
