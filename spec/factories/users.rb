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

FactoryGirl.define do
  factory :user do
    user_name { Faker::Internet.user_name }
    real_name { Faker::Name.name }
    email_address { Faker::Internet.email(name = user_name) }
    phone_number "714-332-1234"
    password "foobar12"
    password_confirmation "foobar12"

    trait :bad_user do
      email_address "wrongwrongwrongwong"
    end
  end
end
