class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [ :destroy ]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@post), notice: "Comment added!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: "Unable to add comment." }
      end
    end
  end

  def destroy
  if @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path(@post), notice: "Comment deleted." }
    end
  else
      respond_to do |format|
        format.html { redirect_to posts_path(@post), alert: "Unable to delete comment." }
      end
  end
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
