require 'rails_helper'

RSpec.describe User, type: :model do
  it "should create a valid user" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "should not create a user without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "should not create a user without a password" do
    user = build(:user, password_digest: nil)
    expect(user).to_not be_valid
  end

  it "should not create a user without a name" do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it "should not create a user with a password less than 6 characters" do
    user = build(:user, password_digest: "12345")
    expect(user).to_not be_valid
  end
end
