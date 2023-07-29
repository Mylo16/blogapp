class PostsController < ApplicationController
  def show
    @user = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:id])
  end

  def index
    @user = User.find_by(id: params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post created successfully'
    else
      flash.now[:alert] = 'Error: Post could not be saved'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
