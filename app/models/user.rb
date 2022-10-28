require 'digest'

class User < ActiveRecord::Base
  def self.encode_password(password)
    md5Hex = Digest::MD5.hexdigest password
    return md5Hex
  end

  def self.create_user(user_name, password)
    if self.exists?(user_name: user_name)
      return false
    end
    self.create!(user_name: user_name, password: encode_password(password))
    return true
  end

  def self.validate_user(user_name, password)
    if !self.exists?(user_name: user_name)
      return "User name does not exist"
    end
    password_hash = self.find_by(user_name: user_name).password
    if encode_password(password) == password_hash
      return ""
    else
      return "Incorrect username or password"
    end
  end
end