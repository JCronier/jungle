class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV["USERNAME"], :password => ENV["PASSWORD"]

  def show
    @statistics = {
      product_count: get_product_count,
      category_count: get_category_count
    }
  end

  private

  def get_product_count
    Product.count()
  end

  def get_category_count
    Category.count()
  end
end
