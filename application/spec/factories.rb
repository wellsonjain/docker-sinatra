require 'factory_girl'

FactoryGirl.define do
  factory :book do
    title "Testing Rails"
    url "http://testingrailsbook.com"

    trait :invalid do
      title nil
    end
  end
end
