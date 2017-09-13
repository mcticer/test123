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

class Analytic < ApplicationRecord
  include Shared::Utils

  # action filters
  before_update :increment_version
  before_validation :fix_tlp

  # validations
  validates(:analytic_name, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 252 bytes in length.' }, length: { maximum: 252 }, uniqueness: true )
  validates(:analytic, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 2 megabytes in length.' }, length: { maximum: 2000000 }, uniqueness: true )
  validates(:analytic_type, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 252 bytes in length.' }, length: { maximum: 252 })
  validates(:analytic_format, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 252 bytes in length.' }, length: { maximum: 252 })
  validates(:tlp, presence: true, inclusion: { in: %w(white green amber red) , message: 'must be flagged as: ["white","green","amber","red"]'}, length: { maximum: 5 })
  validates(:version, presence: true, numericality: true, format: { with: VALID_INTEGER_REGEX })
  validates(:user_id, presence: true, numericality: true, format: { with: VALID_INTEGER_REGEX })


  private

    def increment_version
      self.version += 1
    end

    # sometimes people use yellow, you can't explain it.
    def fix_tlp
      self.tlp = self.tlp.downcase
      self.tlp = "amber" if self.tlp == "yellow"
    end
end
