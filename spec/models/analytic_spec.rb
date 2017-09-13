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

require 'rails_helper'

RSpec.describe Analytic, type: :model do
  before do
    @analytic = Analytic.create(FactoryGirl.attributes_for(:analytic))
    @bad_analytic = Analytic.new(FactoryGirl.attributes_for(:analytic, :bad_analytic))
  end

  # basic configuration works?
  subject { @analytic }

	it { expect respond_to(:analytic_name) }
  it { expect respond_to(:analytic)}
  it { expect respond_to(:analytic_type)}
  it { expect respond_to(:tlp)}
  it { expect respond_to(:user_id)}
  it { expect respond_to(:version)}

  it { expect be_valid }

  describe "validation tests" do
		before do
			@analytic1 = Analytic.create(FactoryGirl.attributes_for(:analytic))
      @analytic2 = Analytic.new(FactoryGirl.attributes_for(:analytic))
    end

    # validates(:analytic_name, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 252 bytes in length.' }, length: { maximum: 252 }, uniqueness: true )
    describe "analytic_name" do
      describe "should be present" do
        before { @analytic1.analytic_name = "" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be printable ascii" do
        before { @analytic1.analytic_name = "abc\f\d\x00test" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be less than 252 characters" do
        before { @analytic1.analytic_name = "a" * 253 }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be unique" do
        before { @analytic2.analytic_name = @analytic1.analytic_name }
        it { expect(@analytic2.valid?).to be false }
      end
    end  # end analytic_name

    # validates(:analytic, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 2 megabytes in length.' }, length: { maximum: 2000000 }, uniqueness: true )
    describe "analytic" do
      describe "should be present" do
        before { @analytic1.analytic = "" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be printable ascii" do
        before { @analytic1.analytic = "abc\f\d\x00test" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be less than 2MB" do
        before { @analytic1.analytic = "a" * 2000001 }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be unique" do
        before { @analytic2.analytic = @analytic1.analytic }
        it { expect(@analytic2.valid?).to be false }
      end
    end # end analytic

    # validates(:analytic_type, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 252 bytes in length.' }, length: { maximum: 252 })
    describe "analytic_type" do
      describe "should be present" do
        before { @analytic1.analytic_type = "" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be printable ascii" do
        before { @analytic1.analytic_type = "abc\f\d\x00test" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be 252 bytes or less" do
        before { @analytic1.analytic_type = "a" * 253 }
        it { expect(@analytic1.valid?).to be false }
      end
    end # end analytic_type

    # validates(:analytic_format, presence: true, format: { with: VALID_TEXT_INPUT_REGEX, message: 'must be entirely printable ascii and no more than 252 bytes in length.' }, length: { maximum: 252 })
    describe "analytic_format" do
      describe "should be present" do
        before { @analytic1.analytic_format = "" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be printable ascii" do
        before { @analytic1.analytic_format = "abc\f\d\x00test" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be 252 bytes or less" do
        before { @analytic1.analytic_format = "a" * 253 }
        it { expect(@analytic1.valid?).to be false }
      end
    end # end analytic_format

    # validates(:tlp, presence: true, inclusion: { in: %w(white green amber red) , message: 'must be flagged as: ["white","green","amber","red"]'}, length: { maximum: 5 })
    describe "tlp" do
      describe "should be present" do
        before { @analytic1.tlp = "" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be 5 or less characters" do
        before { @analytic1.tlp = "a" * 6 }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be white, green, amber, or red" do
        before { @analytic1.tlp = "Burgundy" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should downcase automatically" do
        before { @analytic1.tlp = "RED"; @analytic1.save }
        it(:tlp) { expect(@analytic1.tlp == "red") }
      end
    end # end tlp

    # validates(:version, presence: true, numericality: true, format: { with: VALID_INTEGER_REGEX })
    describe "version" do
      describe "should be present" do
        before { @analytic1.version = "" }
        it { expect(@analytic1.valid?).to be false }
      end

      describe "should be a number" do
        before { @analytic1.version = "a" }
        it { expect(@analytic1.valid?).to be false }
      end
    end # end version

  end

end
