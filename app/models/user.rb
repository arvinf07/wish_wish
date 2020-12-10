

class User < ActiveRecord::Base
  has_many :wishes
  has_many :comments
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true
end
