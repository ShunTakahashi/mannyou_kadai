class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  PER = 5

  def index
    if params[:label_search].present?
      label = Labeling.where(label_id: params[:task][:task_label_ids]).pluck(:task_id)
      @tasks = Task.where(user_id: current_user.id).page(params[:page]).per(PER)
      @tasks = @tasks.where(id: label)
    else
      @tasks = Task.where(user_id: current_user.id).index_order(params).page(params[:page]).per(PER)
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
      render :new, notice: '再度入力してください'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: '編集が完了しました'
    else
      render :edit, notice: '再度入力してください'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: '削除が完了しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, {label_ids: []})
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def ensure_correct_user
    unless current_user.id == @task.user_id
      redirect_to tasks_path
    end
  end

  def check_login
    unless logged_in?
      redirect_to new_session_path
    end
  end

end
