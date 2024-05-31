class User < ApplicationRecord
  has_secure_password

  # NOTE: usernameとpasswordをログイン時に使用する
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
