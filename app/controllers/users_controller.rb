class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
    
  end

  def create
    if logged_in?
      if admin_user?
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_users_path
        else
          render :new
        end
      else
        render :new
      end
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user.id)
      else
        render :new
      end
    end
  end

  def show
    if admin_user?
      @user = User.find(params[:id])
    elsif session[:user_id] == params[:id].to_i
      @user = User.find(params[:id])
    else
      redirect_to tasks_path
    end
  end

  def edit
    if admin_user?
      @user = User.find(params[:id])
    elsif session[:user_id] == params[:id].to_i
      @user = User.find(params[:id])
    else
      redirect_to tasks_path
    end
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user, notice: 'プロフィールは更新されました'
      else
        render :edit
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーは削除されました'
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :admin)
  end
end
