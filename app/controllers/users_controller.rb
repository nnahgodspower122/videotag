# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    # @pagy, @users = pagy(User.all.order(created_at: :asc))
    @q = User.order(created_at: :asc).ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true))
  end

  def show
    @user = User.friendly.find(params[:id])
    # @user = User.find(params[:id])
  end
end
