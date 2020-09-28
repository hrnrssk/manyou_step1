class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :destroy]

  def index
    @users = User.select(:id, :user_name, :email, :password_digest, :admin).page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
