class Admin::UsersController < ApplicationController
  before_action :admin_check
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :destroy_check, only: [:destroy]

  def index
    @users = User.all.includes(:tasks).order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを作成しました'
    else
      render :new, notice: '再度入力してください'
    end
  end

  def edit;
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: '編集が完了しました'
    else
      render :edit, notice: '再度入力してください'
    end
  end

  def show;
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザを削除しました'
  end


  private

  def admin_check
    unless current_user.admin == true
      redirect_to tasks_path, notice: "管理者権限がありません。"
    end
  end

  def destroy_check
    if @user == current_user
      redirect_to admin_users_path, notice: '自分自身の削除はできません'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
