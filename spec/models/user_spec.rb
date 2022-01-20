require "rails_helper"
require "shared/share_example_spec.rb"

RSpec.describe User, type: :model do
  subject {FactoryBot.create(:user)} 

  it "has a valid data" do
    expect(subject).to be_valid
  end

  describe "associations" do
    it {is_expected.to have_many(:orders).dependent(:destroy)}
    it {is_expected.to have_many(:addresses).dependent(:destroy)}
  end

  describe "#email_downcase" do
    let(:user){FactoryBot.create :user, email: "EXAMPLE@gmail.com"}
    
    it "return email downcase" do
      expect(user.email).to eq("example@gmail.com")
    end
  end

  describe "has secure password" do
    it {is_expected.to have_secure_password}
  end

  describe "validations" do
    it "is a valid" do
      is_expected.to be_valid
    end

    it_behaves_like "share presence attribute", %i(user_name full_name email)

    context "with user_name" do
      it {is_expected.to validate_length_of(:user_name).is_at_most(Settings.length.l_50)}
      it {is_expected.to validate_uniqueness_of(:user_name).ignoring_case_sensitivity}
    end

    context "with email" do
      it {is_expected.to validate_length_of(:email).is_at_most(Settings.length.l_255)}
      it {is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

      it "be valid" do
        %w(user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn).each do |e|
          subject.email = e
          expect(subject).to be_valid
        end
      end

      it "be invalid" do
        %w(user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com).each do |e|
          subject.email = e
          expect(subject).to_not be_valid
        end
      end
    end

    context "with password" do
      it {is_expected.to validate_length_of(:password).is_at_least(Settings.length.l_6)}
      it {is_expected.to validate_confirmation_of(:password)}
    end
  end

  describe "Enums" do
    it {is_expected.to define_enum_for(:role).with_values(admin: 1, user: 0)}
  end
end
