class Category < ActiveRecord::Base
	include Sluggable
	#required for category slug

	has_many :posts
	has_many :post_categories
	has_many :posts, through: :post_categories

	validates :name, presence: true

	sluggable_column :name
end
