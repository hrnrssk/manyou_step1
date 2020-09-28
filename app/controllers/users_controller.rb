class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
    
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to user_path(@user.id)
  #   else
  #     render :new
  #   end
  # end

  def create
    if admin_user?
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path
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
    @user = User.find(params[:id])
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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'プロフィールは更新されました' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'ユーザーは削除されました' }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :admin)
  end
end
