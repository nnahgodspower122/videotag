# frozen_string_literal: true

require 'rails_helper'
require 'pry'

# RSpec.describe Post, type: :model do
#   describe "POST create" do
#     current_user = User.first_or_create!(email: 'dean@example.com', password: 'password', password_confirmation: 'password')

#       it 'has a title' do
#         post = Post.new(
#           title: 'ddd',
#           description: 'nnn',
#           body: 'A Valid Body',
#           user: current_user
#         )
#         post.title = 'Has a title'
#         expect(post).to be_valid
#       end
#   end
# end

RSpec.describe 'Posts', type: :controller do
  describe 'POST #create' do
    current_user = User.first_or_create!(email: 'dean@example.com', password: 'password',
                                         password_confirmation: 'password')
    it 'has a title' do
      post = Post.new(
        title: 'ddd',
        description: 'nnn',
        body: 'A Valid Body',
        user: current_user
      )
    end
    it 'is a success' do
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
