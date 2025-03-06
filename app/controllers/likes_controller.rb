class LikesController < ApplicationController
  before_action :set_post

  def create
    if @post.user == current_user
      flash[:alert] = "You cannot like your own post."
      redirect_to posts_path(@post) and return
    end

    @like = @post.likes.build(user: current_user)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_path, notice: "You liked the post!" }
      end
    end
  end


  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @post.user == current_user
      flash[:alert] = "You cannot unlike your own post."
      redirect_to posts_path(@post) and return
    end

    if @like.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_path, notice: "You Unliked the post!" }
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
