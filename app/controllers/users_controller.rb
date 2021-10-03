class UsersController < ApplicationController
  def dashboard
    @users = User.latest
  end

  def managers
    @users = User.joins(:roles).where('roles.code = 2')
  end

  def sec
    @users = User.joins(:roles).where('roles.code = 1')
  end

  def admin
    @users = User.joins(:roles).where('roles.code = 0')
  end

  def normal
    @users = User.joins(:roles).where('roles.code = 3')
  end

  def index
  end
end
