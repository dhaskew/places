FactoryGirl.define do
  factory :message do
    user
    sequence(:text) { |n| "message #{n}" }
    read false
  end

end
