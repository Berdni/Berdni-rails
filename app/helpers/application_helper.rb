module ApplicationHelper
  def profile
    User.where(admin_role: true).first
  end
end
