FactoryBot.define do
  factory :product do |f|
    f.category {FactoryBot.create(:category)}
    f.name {Faker::Coffee.blend_name}
    f.detail {Faker::Food.description}
    f.price {Faker::Number.number(digits: 5)}
  end
end
