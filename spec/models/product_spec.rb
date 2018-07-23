require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should pass all validations" do
      cat = Category.find_or_create_by! name: 'Electronics'
      product = Product.create(
        name: 'Bluetooth Headphones', 
        price: 39.99,
        quantity: 50,
        category_id: cat.id,
      )
    expect(product).to be_valid
    end

    it "should not save without a name" do
      cat = Category.find_or_create_by! name: 'Electronics'
      product = Product.create(
        name: nil,
        price: 39.99,
        quantity: 50,
        category_id: cat.id
      )
    expect(product).to_not be_valid
    end

    it "should not save without a price" do
      cat = Category.find_or_create_by! name: 'Electronics'
      product = Product.create(
        name: 'Bluetooth Headphones',
        price: nil,
        quantity: 50,
        category_id: cat.id
      )
    expect(product).to_not be_valid
    end

    it "should not save without a quantity" do
      cat = Category.find_or_create_by! name: 'Electronics'
      product = Product.create(
        name: 'Bluetooth Headphones',
        price: 39.99,
        quantity: nil,
        category_id: cat.id
      )
    expect(product).to_not be_valid
    end
    
    it "should not save without a category" do
      cat = Category.find_or_create_by! name: 'Electronics'
      product = Product.create(
        name: 'Bluetooth Headphones',
        price: 39.99,
        quantity: 50,
        category_id: nil
      )
    expect(product).to_not be_valid
    end
  end
end
