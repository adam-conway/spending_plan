class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true,
                    uniqueness: true

  enum role: %w(default admin)

  has_many :budgets
end
