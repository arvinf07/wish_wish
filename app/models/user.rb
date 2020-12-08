

class User < ActiveRecord::Base
  has_many :wishes
  has_secure_password
end
