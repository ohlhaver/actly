class UsersController < ApplicationController

def new
  @user = User.new
end

def create
  @user = User.new(params[:user])
  if @user.save
    cookies.permanent[:auth_token] = @user.auth_token
    redirect_back_or(root_url)
  else
    render "new"
  end
end
end
