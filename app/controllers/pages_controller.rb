class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # connection to shop
    shop_url = "https://#{ENV["SHOPIFY_API_KEY"]}:#{ENV["SHOPIFY_API_PASSWORD"]}@#{ENV["SHOP_NAME"]}.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current

    # count = ShopifyAPI::Product.count





    # count products
    limit = 250.0
    @product_count = HTTParty.get(shop_url + "/products/count.json").parsed_response["count"]
    @nb_pages = (@product_count / limit).ceil

    # Get products (250 max per call)
    # @pagination = (1..@nb_pages).to_a
    # @products = []
    # temp = []
    # @pagination.each do |page|
    #   temp = ShopifyAPI::Product.find( :all, :params => { :limit => limit, :page => page } )
    #   temp.each { |product| @products << product }
    # end
    @products = ShopifyAPI::Product.find( :all, :params => { :limit => limit, :page => 1 } )
  end
end
