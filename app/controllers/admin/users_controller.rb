class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :destroy]

  def index
    @users = User.select(:id, :user_name, :email, :password_digest, :admin).page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end

  def show
  end

  private
  def if_not_admin
    redirect_to root_path, notice: '管理者以外はアクセスできません' unless current_user.admin?
  end
  
  # def if_not_admin
  #   unless current_user&.admin?
  #     redirect_to root_path
  #   end
  # end

  def set_user
    @user = User.find(params[:id])
  end
end
