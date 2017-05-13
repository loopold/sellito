module ApplicationHelper
  def login_or_logout_user_link
    current_user ? logout_user_link : login_user_link
  end

  def login_user_link
    link_to 'Login', new_user_session_path
  end

  def logout_user_link
    link_to 'Logout', destroy_user_session_path, method: :delete
  end

  def show_categories_list_for_admin
    categories_link_tag = "<li>#{link_to 'Categories', categories_path}</li>"
    categories_link_tag.html_safe if current_user.is_admin?
  end
end
