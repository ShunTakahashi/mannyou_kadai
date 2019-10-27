class
TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]

  PER = 5

  def index
    if logged_in?
      @tasks = Task.index_order(params).page(params[:page]).per(PER)
    else
      redirect_to new_session_path
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
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def ensure_correct_user
    if @current_user.id !=  params[:id].to_i
      redirect_to tasks_path
    end
  end

end
