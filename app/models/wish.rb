

class Wish < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  #has_many :comments (user also has_many)  comments(join table) and comment model that belong to both user and wish
  # validates :name, uniqueness: true (add scope)
end