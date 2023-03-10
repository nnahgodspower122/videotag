# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
    @q = Post.order(created_at: :asc).ransack(params[:q])
    @pagy, @posts = pagy(@q.result(distinct: true))
    # if current_user.active?
    # if current_user&.subscription_status != "active"
    #   @posts = Post.free
    # else
    #    @posts = Post.all
    #  end
  end

  def show
    # set_meta_tags title: 'ffff',
    #   description: 'ddddd',
    #   keywords: 'seo, rails, ruby'

    if @post.premium? && current_user&.subscription_status != 'active'
      redirect_to posts_path, alert: 'You are not a premium subscriber'
    end

    @comment = Comment.new
    @commentable = @post
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def edit
    return if @post.user == current_user

    redirect_to posts_path, alert: 'You are not authorized'
  end

  # def upvote
  #   # @post = Post.find(params[:id])
  #   # @post.upvote_by current_user
  #   # render "vote.js.erb"
  #   if current_user.voted_up_on? @post
  #     @post.unvote_by current_user
  #   else
  #     @post.upvote_by current_user
  #   end
  #   redirect_to @post
  # end

  # def downvote
  #   if current_user.voted_down_on? @post
  #     @post.unvote_by current_user
  #   else
  #     @post.downvote_by current_user
  #   end
  #   redirect_to @post
  # end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @post.user == current_user
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        else
          render :edit, status: :unprocessable_entity
        end
      end
    else
      redirect_to posts_path, alert: 'You are not authorized'
    end
  end

  def destroy
    # unless @post.user == current_user
    #   redirect_to posts_path, alert: 'You are not authorized'
    # else
    #   @post.destroy
    #   redirect_to posts_url, notice: "Post was successfully destroyed."
    # end
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :premium, :description)
  end
end
