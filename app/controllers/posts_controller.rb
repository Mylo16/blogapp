class PostsController < ApplicationController
  def show
    @user = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:id])
  end

  def index
    @user = User.find_by(id: params[:user_id])
  end
end
