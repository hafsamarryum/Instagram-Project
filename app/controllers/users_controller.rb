class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
      if params[:query].present?
        query = "%#{params[:query].downcase}%"
        @users = User.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ?", query, query)
        # Assign the first matched user to @user for the profile section
        @user = @users.first 
        @posts = Post.where(user_id: @users.pluck(:id)) # Fetch posts of found users
      else
        @users = []
        @posts = []
        @user = nil
      end
    end
    


    def show
        @user = User.find(params[:id])
        @posts = @user.posts.joins(:images_attachments).distinct.includes(:likes, :comments)
        @saved = Post.joins(:bookmarks).where("bookmarks.user_id=?", current_user.id).joins(:images_attachments).distinct.
        includes(:likes, :comments) if @user == current_user
    end
   
    def update
        if @user.update(user_params)
          respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace("user_profile", partial: "users/profile", locals: { user: @user }) }
            format.html { redirect_to @user, notice: "Profile updated successfully." }
        end
        else
          render :edit, status: :unprocessable_entity
        end
    end
      

    private
    def user_params
        params.require(:user).permit(:name, :website, :bio, :gender, :birthday, :location, :avatar)
    end
end
