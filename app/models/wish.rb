

class Wish < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  #has_many :comments
end