class User < ActiveRecord::Base
  include BCrypt

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
