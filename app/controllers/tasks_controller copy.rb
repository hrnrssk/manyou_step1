class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(deadline: :desc)
      @search_params = task_search_params
    else
      @search_params = task_search_params
      @tasks = Task.search(@search_params)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
      if @task.save
        redirect_to @task, notice: 'Feed was successfully created.'
      else
        render :new
      end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :detail, :deadline, :status, :priority, :author)
    end

    def task_search_params
      params.fetch(:search, {}).permit(:name, :detail, :deadline, :status, :priority, :author)
    end
end
