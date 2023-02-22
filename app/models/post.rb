class Post < ApplicationRecord
  belongs_to :user, counter_cache: :post_count

  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 200}
  validates :body, presence: true, length: {maximum: 5000}

  scope :free, -> {where(premium: false)}
  scope :premium, -> {where(premium: true)}

  def active?
    subscription_status == "active"
  end

  # def upvote_percentage
  #   cached_votes_up.to_d/cached_votes_total.to_d*100
  # end

  # def downvote_percentage
  #   cached_votes_down.to_d/cached_votes_total.to_d*100
  # end

end
