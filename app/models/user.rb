

class User < ActiveRecord::Base
  has_many :wishes
  #has_many :comments, through: :wishes
  has_secure_password
  validates :username, presence: true
  # validates :wish_ids, uniqueness: true
  validates :username, uniqueness: true
end
