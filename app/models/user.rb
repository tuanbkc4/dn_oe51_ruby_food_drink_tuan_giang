class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  before_save{:email_downcase}

  validates :userName, presence: true,
    length: {maximum: Settings.length.l_50},
    uniqueness: true

  validates :fullName, presence: true

  validates :email, presence: true,
    length: {maximum: Settings.length.l_255},
    format: {with: Settings.regex.email_regex},
    uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.length.l_6}

  enum role: {
    admin: 1,
    user: 0
  }

  has_secure_password

  private

  def email_downcase
    email.downcase!
  end
end
