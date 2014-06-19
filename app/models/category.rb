class Category < ActiveRecord::Base
	has_many :posts
	has_many :post_categories
	has_many :posts, through: :post_categories
end
