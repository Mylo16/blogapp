class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user.posts_counter = @user.posts.count
  end

  def index
    @users = User.all
  end
end
