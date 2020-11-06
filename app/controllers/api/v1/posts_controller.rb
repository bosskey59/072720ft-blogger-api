class Api::V1::PostsController < ApplicationController
  before_action :set_post, only:[:show, :update, :destroy]

  def index
    @posts = Post.all.sort_by{|p| p.id}
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    # byebug
    if @post.save
      render json: @post
    else
      render json:{ errors: @post.errors.full_messages}
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json:{errors: @post.errors.full_messages}
    end
  end

  def destroy
    @post.destroy
    render json: @post
  end

  private

  def set_post
    @post = Post.find_by_id(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :author, :content, :likes)
  end
  
end
