require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:age)}
  it { should validate_presence_of(:user_type)}

  describe "validates factory" do
    it "should validates factroy bot" do
      expect(build(:user)).to be_valid
    end
  end
end
