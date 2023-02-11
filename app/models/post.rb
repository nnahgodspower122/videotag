class Post < ApplicationRecord
  belongs_to :user, counter_cache: :post_count

  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 200}
  validates :body, presence: true, length: {maximum: 5000}

  acts_as_votable

  scope :free, -> {where(premium: false)}
  scope :premium, -> {where(premium: true)}

  def active?
    subscription_status == "active"
  end

end
