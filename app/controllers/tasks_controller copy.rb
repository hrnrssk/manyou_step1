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
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Feed was successfully created.' }
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
      params.require(:task).permit(:name, :detail, :deadline, :status, :priority, :author)
    end

    def task_search_params
      params.fetch(:search, {}).permit(:name, :detail, :deadline, :status, :priority, :author)
    end
end
