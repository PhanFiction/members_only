class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    # @user is set by the before_action
    @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
