# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # ::lockable, :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id, inverse_of: :id, dependent: :destroy
  has_many :posts, dependent: :restrict_with_error
  has_many :likes, dependent: :destroy

  extend FriendlyId
  friendly_id :email, use: :slugged

  after_create do
    Stripe::Customer.create(email: email)
    # customer = Stripe::Customer.create(email: email)
    # update(stripe_customer_id: customer.id)
  end
end
