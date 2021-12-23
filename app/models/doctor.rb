################################################################################
# Model:  Doctor
#
# Purpose:
#
# Doctor attributes:
#   name              - name:           string,  not NULL, unique
#
#  23.12.2021 ZT
################################################################################
class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments

  validates :name,  presence: true, uniqueness: true
end
