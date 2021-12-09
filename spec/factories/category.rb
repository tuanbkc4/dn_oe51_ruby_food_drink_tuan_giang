FactoryBot.define do
  factory :category do |f|
    f.name {Faker::Food.dish}
    f.parent_id {Category.first&.id || nil}
  end
end
