class Customer < ApplicationRecord
  has_secure_token :access_token

  validates :name, presence: true

  before_create :create_token

  private
  def create_token
    self.access_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(6)
      break token unless Customer.where(access_token: token).exists?
    end
  end
end
