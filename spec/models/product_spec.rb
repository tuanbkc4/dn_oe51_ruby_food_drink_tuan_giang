require "rails_helper"
require "shared/share_example_spec.rb"

RSpec.describe Product, type: :model do
  let(:category){FactoryBot.create :category }

  subject {FactoryBot.create(:product)} 

  it "has a valid data" do
    expect(subject).to be_valid
  end

  describe "associations" do
    it {is_expected.to have_many(:order_details).dependent(:destroy)}
    it {is_expected.to have_many(:orders).through(:order_details)}
    it {is_expected.to belong_to(:category)}
    it {is_expected.to have_one_attached(:image)}
  end

  describe "validations" do
    it "is a valid" do
      is_expected.to be_valid
    end

    it_behaves_like "share presence attribute", %i(name price detail)

    context "with name" do
      it {is_expected.to validate_length_of(:name).is_at_most(Settings.length.l_255)}
    end

    context "with price" do
      it {is_expected.to validate_numericality_of(:price)}
    end
  end

  describe "scope" do
    before {category}
    let!(:category_1){FactoryBot.create :category, parent_id: Category.first.id}
    let!(:product_1){FactoryBot.create :product, name: "product1", category_id: Category.second.id}
    let!(:product_2){FactoryBot.create :product, name: "product2", category_id: Category.second.id}
    let!(:product_3){FactoryBot.create :product, name: "product3", category_id: Category.second.id}
    let!(:product_4){FactoryBot.create :product, name: "product4", category_id: Category.second.id}
    let!(:product_5){FactoryBot.create :product, name: "product5", category_id: Category.second.id}
    let!(:product_6){FactoryBot.create :product, name: "product6", category_id: Category.second.id}
    let!(:product_7){FactoryBot.create :product, name: "product7", category_id: Category.second.id}

    
    it "return all products with created at newest" do
      products = Product.all_product_sort_desc
      expect(products).to eq([product_7, product_6, product_5, product_4, product_3, product_2, product_1])
    end

    it "return latest product" do
      products = Product.latest_product
      expect(products).to eq([product_7, product_6, product_5, product_4, product_3, product_2])
    end
  end 
  
  describe "after initialize" do
    let!(:product_1){FactoryBot.create :product}
    let!(:product_2){FactoryBot.create :product, rating: 5}

    it "Return rating equal 1 after initialization does not enter the value" do
      expect(product_1.rating).to eq(1)
    end

    it "Returns rating value after initialization enter the value rating" do
      expect(product_2.rating).to eq(5)
    end
  end
  
end
