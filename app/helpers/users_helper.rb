module UsersHelper
  def auth_user(name)
    User.find_by(name: name)
  end
end
