require 'rails_helper'

describe Domain, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }

    it "validates uniqueness of name" do
      create(:domain)

      expect(subject).to validate_uniqueness_of(:name)
    end
  end
end
