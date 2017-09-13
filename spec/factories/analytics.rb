# == Schema Information
#
# Table name: analytics
#
#  id              :integer          not null, primary key
#  analytic_name   :string(255)
#  analytic        :string(255)
#  analytic_type   :string(255)
#  analytic_format :string(255)
#  tlp             :string(255)
#  user_id         :integer
#  version         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :analytic do
    analytic_name { Faker::Lorem.sentence(3,false,5) }
    analytic { "/totes badness pcre #{Faker::Lorem.sentence(1,3)}/" }
    analytic_type { "email subject pcre: #{Faker::Lorem.sentence(3)}" }
    analytic_format {['pcre','cpl','hostname','subject','sender','md5','sha256','ipv4','ipv6'].sample }
    tlp {['green','white','yellow','red'].sample }
    user_id 1
    version { rand(64) }

    trait :bad_analytic do
      tlp "ron burgundy"
    end
  end
end
