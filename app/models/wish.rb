

class Wish < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id}
end