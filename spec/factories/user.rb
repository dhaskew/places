FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "awfulPass"
    password_confirmation "awfulPass"
  end

  trait :evernote_connected do
    evernote_token 'foobar_token_value'
    evernote_token_dttm Time.now
  end

end
