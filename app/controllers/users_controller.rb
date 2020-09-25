class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if session[:user_id] == params[:id].to_i
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

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
