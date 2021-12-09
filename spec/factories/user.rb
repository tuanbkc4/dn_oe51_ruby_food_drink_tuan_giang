FactoryBot.define do
  factory :user do |f|
    f.user_name {Faker::Name.first_name}
    f.full_name {Faker::Name.name_with_middle}
    f.email {Faker::Internet.email}
    f.password {"123456"}
    f.password_confirmation {"123456"}
  end
end
