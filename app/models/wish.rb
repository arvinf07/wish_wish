

class Wish < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  #has_many :comments
  # validates :name, uniqueness: true
end