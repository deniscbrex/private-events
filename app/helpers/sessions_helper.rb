module SessionsHelper
  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def ensure_logged_in
    unless logged_in?
      flash[:info] = "Please log in"
      redirect_to login_path
    end
  end
end
