class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_path, notice: "User like the post!" }
      end
    end
  end


  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_path, notice: "User Unlike the post!" }
      end
    end
  end


  private

  def set_post
    if params[:post_id]
      @post = Post.find(params[:post_id])
    else
      @post = Like.find(params[:id]).post
    end
  end
end
