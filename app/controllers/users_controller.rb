class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    session[:redirect_url] = '/users'
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    session[:redirect_url] = "/users/#{@user.id}"
  end
end
