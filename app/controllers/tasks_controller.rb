class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
  if logged_in?
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(3)
    if params[:task].present?
      @tasks = @tasks.search_with_name_and_status(params[:task][:name], params[:task][:status]) if params[:task][:name].present? && params[:task][:status].present?
      @tasks = @tasks.search_with_name(params[:task][:name]) if params[:task][:name].present?
      @tasks = @tasks.search_with_status(params[:task][:status]) if params[:task][:status].present?
      if params[:task][:label_id].present?
        label = Label.find(params[:task][:label_id])
        @tasks = label.tasks.where(user_id: current_user.id).page(params[:page]).per(3)
      end
    elsif params[:sort_expired].present?
      @tasks = current_user.tasks.order(deadline: :desc).page(params[:page]).per(3)
    elsif params[:sort_priority].present?
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(3)
    end
  else
    flash[:notice] = "ログインしてください"
    redirect_to new_session_path
  end
end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.create(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :detail, :deadline, :status, :priority, label_ids: [])
    end
end
