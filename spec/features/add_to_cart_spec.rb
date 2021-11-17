require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel2.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a product and see its details" do
    # ACT
    visit root_path
    # save_screenshot
    first('article.product footer button').click

    # VERIFY
    expect(page).to have_content "My Cart (1)"

    # DEBUG
    # save_screenshot
  end
end
