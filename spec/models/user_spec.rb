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

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(user_name: "example", email_address: "example@moonbasealpha.com", phone_number: "(714)-234-5678", password: "foobar12", password_confirmation: "foobar12", api_key: "3f433998fee0c04be3d56651d2141883032f4cf5afc86da6")
  end

	subject { @user }

	it { expect respond_to(:user_name) }
	it { expect respond_to(:email_address) }
	it { expect respond_to(:real_name) }
	it { expect respond_to(:password_digest) }
	it { expect respond_to(:password) }
	it { expect respond_to(:password_confirmation) }
	it { expect respond_to(:authenticate) }
  it { expect respond_to(:api_key) }
	it { expect respond_to(:remember_token) }
  it { expect respond_to(:admin) }

	it { expect be_valid }

	describe "validation tests" do
		before do
			@user1 = User.create(user_name: "example", email_address: "example@moonbasealpha.com", password: "foobar12", password_confirmation: "foobar12", real_name: "example")
			@user2 = User.new(user_name: "example1", email_address: "example1@moonbasealpha.com", password: "foobar12", password_confirmation: "foobar12", real_name: "example1")
    end

    describe "user should not be an admin" do
      it { expect(@user.admin).to be false }
    end

		describe "user_name should be unique" do
			before { @user2.user_name = @user1.user_name }
			it { expect(@user2.valid?).to be false }
		end

		describe "email_address should be unique" do
			before { @user2.email_address = @user1.email_address }
			it { expect(@user2.valid?).to be false }
		end

		describe "displayed name should be unique" do
			before { @user2.real_name = @user1.real_name }
			it { expect(@user2.valid?).to be false }
		end
	end

	describe "user_name should be less than 33 characters" do
		before { @user.user_name = 'a' * 33 }
		it { expect(@user.valid?).to be false }
	end

  describe "user_name should be more than 2 characters" do
		before { @user.user_name = "aa" }
		it { expect(@user.valid?).to be false }
	end

	describe "user_name should not be blank" do
		before { @user.user_name = "" }
		it { expect(@user.valid?).to be false }
	end

	describe "email_address should be valid format" do
		before { @user.email_address = "notvalid" }
		it { expect(@user.valid?).to be false }
	end

	describe "email_address should be shorter than 129 characters" do
		before { @user.email_address = "a@a" + ("a" * 12) + ".com" }
		it { expect(@user.valid?).to be false }
	end

  describe "phone number should be allowed to be blank" do
		before { @user.phone_number = "" }
		it { expect(@user.valid?).to be true }
	end

	describe "phone number should be more than 2 characters" do
		before { @user.phone_number = "aa" }
		it { expect(@user.valid?).to be false }
	end

	describe "phone number should be less than 32 characters" do
		before { @user.phone_number = "a" * 33 }
		it { expect(@user.valid?).to be false }
	end

  describe "phone number should have digits in it" do
    before { @user.phone_number = "333" }
    it { expect(@user.valid?).to be true }
  end

	describe "real name should be allowed to be blank" do
		before { @user.real_name = "" }
		it { expect(@user.valid?).to be true }
	end

	describe "real name should be more than 2 characters" do
		before { @user.real_name = "aa" }
		it { expect(@user.valid?).to be false }
	end

	describe "real name should be less than 65 characters" do
		before { @user.real_name = "a" * 65 }
		it { expect(@user.valid?).to be false }
	end

  describe "api_key should be present" do
    before { @user.api_key = "" }
    it { expect(@user.valid?).to be false }
  end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = "" }
		it { expect(@user.valid?).to be false }
	end

	describe "when password is less than 8 characters" do
		before { @user.password = @user.password_confirmation = "a234567" }
		it { expect(@user.valid?).to be false }
	end

	describe "when password is larger than 64 characters" do
		before { @user.password = @user.password_confirmation = "a1"*33 }
		it { expect(@user.valid?).to be false }
	end

	describe "when password is not alpha-numeric" do
		before { @user.password = @user.password_confirmation = "1234567890123456" }
		it { expect(@user.valid?).to be false }
	end

	describe "when password does not match confirmation" do
		before { @user.password_confirmation = "mismatched" }
		it { expect(@user.valid?).to be false }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { expect(@user.valid?).to be false }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(:email_address => @user.email_address) }

		describe "with valid password" do
			it { expect(found_user.authenticate(@user.password)).to be_truthy }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { expect(user_for_invalid_password).to be false }
			specify { expect(user_for_invalid_password).to be false }
		end
	end

	describe "test remember token is populated after save" do
		before { @user.save }
		it(:remember_token) { expect(@user.remember_token).to_not be_blank }
	end
end
