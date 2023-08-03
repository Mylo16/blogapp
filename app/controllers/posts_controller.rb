class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  load_and_authorize_resource
  def show
    @post = Post.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_path(id: @post.author_id), notice: 'Post created successfully'
    else
      flash.now[:alert] = 'Error: Post could not be saved'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:posts_counter)
    @post.destroy!
    redirect_to user_posts_path(id: @author.id), notice: 'Post was deleted successfully'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
