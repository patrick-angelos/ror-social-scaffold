FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    sequence(:password) { |n| "password#{n}" }
  end

  factory :friend, class: 'User' do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    sequence(:password) { |n| "password#{n}" }
  end

  factory :post do
    user
    sequence(:content) { |n| "Content#{n}" }
  end

  factory :comment do
    user
    post
    sequence(:content) { |n| "Content#{n}" }
  end

  factory :like do
    user
    post
  end

  factory :friendship do
    user
    friend
    status { true }
  end
end
