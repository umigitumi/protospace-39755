class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @prototype = @user.prototype.includes(:user)
  end

end