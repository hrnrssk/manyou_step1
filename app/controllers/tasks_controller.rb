class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:task].present?
      @tasks = @tasks.search_with_name_and_status(params[:task][:name], params[:task][:status]) if params[:task][:name].present? && params[:task][:status].present?
      @tasks = @tasks.search_with_name(params[:task][:name]) if params[:task][:name].present?
      @tasks = @tasks.search_with_status(params[:task][:status]) if params[:task][:status].present?
    elsif params[:sort_expired].present?
      @tasks = Task.all.order(deadline: :desc)
    end
    # @tasks = @tasks.order(deadline: :desc) if params[:sort_expired].present?
  end

  def new
    @task = Task.new
  end

  def create
    binding.irb
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

  def show
  end

  def edit
  end

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

    # def search_params
    #   params.require(:task).permit(:name, :detail, :deadline, :status, :priority, :author, :sort_expired, :search)
    # end

    # def search_tasks(search_params)
    #   if search_params[:name].blank? && search_params[:status].blank?
    #     @tasks = @tasks
    #   elsif search_params[:status].blank?
    #     @tasks = @tasks.search_with_name(search_params)
    #   elsif search_params[:name].blank?
    #     @tasks = @tasks.search_with_status(search_params)
    #   else
    #     @tasks = @tasks.search_with_name_and_status(search_params)
    #   end
    # end
  
    # def sort_tasks(search_params)
    #   if search_params[:sort_expired] == t('tasks.deadline_sort_desc')
    #     @tasks = @tasks.order(deadline: :desc)
    #   elsif search_params[:sort_expired] == t('tasks.created_at_sort_desc')
    #     @tasks = @tasks.order(created_at: :desc)
    #   else
    #     @tasks = @tasks
    #   end
    # end
end
