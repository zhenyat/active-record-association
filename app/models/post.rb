################################################################################
# Model:  Post
#
# Purpose:
#
# Post attributes:
#   content - string
#
#  24.12.2021 ZT
################################################################################
class Post < ApplicationRecord
  has_and_belongs_to_many :authors
end
