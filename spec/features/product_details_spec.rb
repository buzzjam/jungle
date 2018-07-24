require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature , js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  end

  scenario "See product details" do
    visit root_path
    page.find('.product').find('header').click
    expect(page).to have_content("Description")
    # save_screenshot

  end

  scenario "See product details" do
    visit root_path
    page.find('.product').find('.btn-default').click
    expect(page).to have_content("Description")
    # save_screenshot

  end

end
