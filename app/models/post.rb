class Post < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :without_parent, -> { where(parent_slug: nil) }
  scope :with_parent, -> (parent_slug) {where(parent_slug: parent_slug) }
end
