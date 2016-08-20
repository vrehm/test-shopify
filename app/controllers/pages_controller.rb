class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @shop_url = "https://#{ENV["SHOPIFY_API_KEY"]}:#{ENV["SHOPIFY_API_PASSWORD"]}@#{ENV["SHOP_NAME"]}.myshopify.com/admin"
    ShopifyAPI::Base.site = @shop_url
    shop = ShopifyAPI::Shop.current

    # Get a specific product
    @products = ShopifyAPI::Product.all
  end
end
