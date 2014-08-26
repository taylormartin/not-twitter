FactoryGirl.define do
  # enables `create :user` in specs
  # v- this is create :user
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "awfulPass"
    password_confirmation "awfulPass"
  end

  # v- create :moderator
  factory :moderator, class: User do
    #   ...
  end
end
