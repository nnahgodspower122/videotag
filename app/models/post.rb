class Post < ApplicationRecord
  belongs_to :user, counter_cache: :post_count

  validates :title, presence: true
  validates :body, presence: true
end
