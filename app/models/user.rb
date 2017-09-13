# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)
#  real_name       :string(255)
#  email_address   :string(255)
#  phone_number    :string(255)
#  password_digest :string(255)
#  active          :boolean          default(FALSE)
#  remember_token  :string(255)
#  api_key         :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  include Shared::Utils
	has_secure_password

  before_validation :generate_api_key
	before_save { |user| user.email_address = email_address.downcase }
	before_save :create_remember_token

  # validations
	validates(:user_name, presence: true, length: { minimum: 3, maximum: 32 }, uniqueness: true )
	validates(:email_address, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 128 }, uniqueness: true )
  validates(:phone_number, presence: true, allow_blank: true, format: { with: VALID_PHONE_NUMBER_REGEX }, length: { maximum: 32 }, uniqueness: false )
  validates(:api_key, presence: true, format: { with: VALID_APIKEY_REGEX }, length: {minimum: 48, maximum: 48}, uniqueness: true)
	validates(:password_digest, presence: true)
	validates(:password, presence: true, length: { minimum: 8, maximum: 64 }, format: { with: VALID_PASSWORD_REGEX, message: 'must be 8-64 characters and be alphanumeric.' }, :on => :create )
	validates(:password_confirmation, presence: true, :on => :create)
	validates(:real_name, length: { minimum: 3, maximum: 64 }, allow_blank: true, uniqueness: true)

  def generate_api_key
    self.api_key = SecureRandom.hex(24) if self.api_key.nil?
  end

	private

		def create_remember_token
      self.remember_token ||= SecureRandom.urlsafe_base64
		end
end
