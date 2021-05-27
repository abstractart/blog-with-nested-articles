class Post < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :without_parent, -> { where(parent_slug: nil) }

  has_many :subposts, class_name: 'Post', foreign_key: 'parent_slug', primary_key: 'slug', dependent: :destroy
  belongs_to :parent_post, class_name: 'Post', foreign_key: 'parent_slug', primary_key: 'slug', optional: true
end
