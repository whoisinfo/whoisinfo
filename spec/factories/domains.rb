FactoryGirl.define do
  factory :domain do
    sequence(:name) { |n| "foo.#{n}" }
    expires_on Date.today
  end
end
