class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired_asc]
      @tasks = Task.all.order(expired_at: :asc)
    elsif params[:sort_expired_desc]
      @tasks = Task.all.order(expired_at: :desc)
    elsif params[:search]
      @tasks = Task.all
      @tasks = @tasks.search(params[:task][:title])
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: '登録が完了しました'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: '編集が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: '削除が完了しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
