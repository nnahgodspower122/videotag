# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, counter_cache: :post_count

  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :body, presence: true, length: { maximum: 5000 }
  has_many :likes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders history]

  def should_generate_new_friendly_id?
    title_changed?
  end

  scope :free, -> { where(premium: false) }
  scope :premium, -> { where(premium: true) }

  def active?
    subscription_status == 'active'
  end

  # def upvote_percentage
  #   cached_votes_up.to_d/cached_votes_total.to_d*100
  # end

  # def downvote_percentage
  #   cached_votes_down.to_d/cached_votes_total.to_d*100
  # end
end
