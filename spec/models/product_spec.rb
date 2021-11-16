require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "saves with valid attributes" do
      @category = Category.find(1)
      @product = Product.new(name: "product", price: 100, quantity: 2, category: @category)
      @product.save
      expect(@product).to be_valid
    end
    it "does not save without a name" do
      @category = Category.find(1)
      @product = Product.new(name: nil, price: 100, quantity: 2, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to eq(["can't be blank"])
    end
    it "does not save without a price" do
      @category = Category.find(1)
      @product = Product.new(name: "product", price: nil, quantity: 2, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to eq(["is not a number", "can't be blank"])
    end
    it "does not save without a quantity" do
      @category = Category.find(1)
      @product = Product.new(name: "product", price: 100, quantity: nil, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to eq(["can't be blank"])
    end
    it "does not save without a category" do
      @category = Category.find(1)
      @product = Product.new(name: "product", price: 100, quantity: 2, category: nil)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to eq(["can't be blank"])
    end
  end
end
