class BookmarksController < ApplicationController
  before_action :set_post, only: [ :create ]

  def create
    @bookmark = current_user.bookmarks.create(post: @post)
    flash.now[:notice] = "Post bookmarked successfully!"
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: "Post Bookmarked successfully!" }
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @post = @bookmark.post
    @bookmark.destroy
    flash.now[:alert] = "Bookmark removed!"
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, alert: "Bookmark removed!" }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end


