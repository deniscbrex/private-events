class UsersController < ApplicationController
  before_action :ensure_logged_in, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Logged in successfully"
      redirect_to root_url
    else
      flash.now[:danger] = "Account creation failed!"
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @events = @user.events
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
