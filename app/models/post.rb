class Post < ApplicationRecord
  belongs_to :user, counter_cache: :post_count

  validates :title, presence: true
  validates :body, presence: true

  scope :free, -> {where(premium: false)}
  scope :premium, -> {where(premium: true)}

  def active?
    subscription_status == "active"
  end

end
