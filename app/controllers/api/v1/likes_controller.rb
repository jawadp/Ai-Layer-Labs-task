class Api::V1::LikesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :post

  def create
    @post = Post.find(params[:post_id])
    if @post.likes.exists?(user: current_user)
      render json: { error: 'You have already liked this post' }, status: :unprocessable_entity
    else
      @like = @post.likes.new(user: current_user)

      if @like.save
        render json: @like, status: :created
      else
        render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: @post.id)

    if @like
      @like.destroy
      head :no_content
    else
      render json: { error: 'Like not found' }, status: :not_found
    end
  end
end
