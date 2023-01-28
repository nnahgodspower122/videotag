class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # ::lockable, :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id

  has_many :posts, dependent: :restrict_with_error
end