FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.safe_email}
    age  {Faker::Number.between(from: 1, to: 100)}
    user_type {[:admin, :user].sample}

  end
end
