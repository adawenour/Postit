class Category < ActiveRecord::Base
	has_many :posts
	has_many :post_categories
	has_many :posts, through: :post_categories

	validates :name, presence: true

	#required for category slug
	before_save :generate_slug

	def to_param
		self.slug
	end

	def generate_slug
		self.slug = self.name.gsub(" ", "-").downcase
	end
end
