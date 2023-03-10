# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy

  MIN_BODY_LENGTH = 2
  MAX_BODY_LENGTH = 1000

  validates :body, presence: true
  validates :body, length: { minimum: MIN_BODY_LENGTH, maximum: MAX_BODY_LENGTH }
end
