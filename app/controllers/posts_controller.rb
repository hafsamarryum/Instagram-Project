class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [ :show, :destroy, :archive, :unarchive ]

  def index
    @posts = Post.where(archived: false).includes(:images_attachments, :user, :likes).order(created_at: :desc)
    @post = Post.new
  end


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      flash[:alert] = "Something went wrong ..."
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @likes = @post.likes.includes(:user)
    @is_liked = @post.liked_by?(current_user)
    @is_bookmarked = @post.is_bookmarked(current_user)
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = "Post deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "You don't have permission to do that!"
    end
    redirect_to posts_path
  end

  def archive
    if @post.user == current_user
      @post.update(archived: true)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove("post_#{@post.id}")
        end
        format.html { redirect_to posts_path, notice: "Post archived successfully!" }
      end
    else
      flash[:alert] = "You don't have permission to do that!"
      redirect_to posts_path
    end
  end

  def unarchive
    if @post.user == current_user
      @post.update(archived: false)

     respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("post_#{@post.id}") do
            render partial: "posts/posts_list", locals: { post: @post }
          end
        end
        format.html { redirect_to posts_path, notice: "Post unarchived successfully!" }
      end
    else
      flash[:alert] = "You don't have permission to do that!"
      redirect_to posts_path
    end
  end

  def archived
    @posts = current_user.posts.archived.order(created_at: :desc)
  end


  private

  def find_post
    @post = Post.find_by(id: params[:id])
    return if @post

    flash[:danger] = "Post not found!"
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
