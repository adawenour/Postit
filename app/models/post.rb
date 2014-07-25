class Post < ActiveRecord::Base
	include Voteable
	include Sluggable

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	belongs_to :user #1:M
	has_many :comments 
	has_many :post_categories
	has_many :categories, through: :post_categories 

	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: true
	validates_presence_of :categories

	sluggable_column :title

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
