FactoryGirl.define do
  
  sequence :email do |n|
    "ambassador#{n}@mbsy.co"
  end
  
  factory :ambassador, class: Mbsy::Ambassador do
    first_name Faker::Name.first_name 
    last_name Faker::Name.last_name
    email FactoryGirl.generate(:email)
    amount 0
  end
  
end