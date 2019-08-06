class SessionsController < ApplicationController
  def new
    @session = User.new
  end

  def create
    if @user = auth_user(params[:name].capitalize)
      log_in @user
      flash[:success] = "Login Successful!"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "You are not a member!"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
