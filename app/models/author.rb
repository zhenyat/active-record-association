################################################################################
# Model:  Author
#
# Purpose:
#
# Author attributes:
#   name  - string,  not NULL, unique
#
#  24.12.2021 ZT
################################################################################
class Author < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :name,  presence: true, uniqueness: true
end
