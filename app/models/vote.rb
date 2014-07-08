class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :voteable, polymorphic: true

	validates_uniqueness_of :user, scope: [:voteable_id, :voteable_type]
	

	# validates_uniqueness_of :user, scope: :voteable
	# syntax not allowing to vote on both objects of the same id, you can either vote on post or comments not both.
end
