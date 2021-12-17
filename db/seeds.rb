User.create(
  user_name: "admin",
  full_name: "Admin",
  email: "adminfooddrink@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

category_parent = ["Drink", "Food"]
category_child_food = ["Fast Food", "Fruits", "Meat"]
category_child_drink = ["Milk", "Water", "Hot drink"]

category_parent.each do |item|
  Category.create(name: item)
end

category_child_food.each do |item|
  Category.create(
    name: item,
    parent_id: 1
  )
end

category_child_drink.each do |item|
  Category.create(
    name: item,
    parent_id: 2
  )
end

User.create!(user_name: "user",
  full_name: "Example User",
  email: "example@railstutorial.org",
  password: "123456",
  password_confirmation: "123456")
  20.times do |n|
    user_name = "user-#{n}"
    full_name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(user_name: user_name,
    full_name: full_name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 0
  )
  end

4.times do
  Product.create(
    name: Faker::Food.dish,
    detail: Faker::Food.description,
    price: 20000,
    image: "https://thumbs.dreamstime.com/b/fast-food-burger-18136724.jpg",
    category_id: 1,
    rating: 1
  )
end

4.times do
  Product.create(
    name: Faker::Coffee.blend_name,
    detail: Faker::Food.description,
    price: 20000,
    image: "https://www.comunicaffe.com/wp-content/uploads/2016/07/coffee-cup.jpg",
    category_id: 2,
    rating: 1
  )
end
