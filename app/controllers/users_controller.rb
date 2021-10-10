class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    authorize :user, :dashboard?
    @users = User.latest
  end

  def managers
    authorize :user, :managers?
    @users = User.joins(:roles).where('roles.code = 2')
  end

  def sec
    authorize :user, :sec?
    @users = User.joins(:roles).where('roles.code = 1')
  end

  def admin
    authorize :user, :admin?
    @users = User.joins(:roles).where('roles.code = 0')
  end

  def normal
    authorize :user, :normal?
    @users = User.joins(:roles).where('roles.code = 3')
  end

  def change_role
    @user = get_user
    @roles = [['مستخدم', 3], ['ادمن', 0], ['سكرتاريه', 1], ['مدير', 2]]
  end

  def change_role_save
    @user = get_user
    @user.add_role get_role
    # @user.save
    flash[:success] = 'تم تغيير صلاحيه المستخدم بنجاح'
    redirect_to dashboard_path
  end

  private
  def get_role
    params.require(:change_role).permit(:role)['role']
  end

  def get_user
    User.find(params[:id])
  end

end
