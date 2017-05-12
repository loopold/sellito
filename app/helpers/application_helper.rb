module ApplicationHelper
  def current_user_is_admin
    current_user && current_user.is_admin?
  end

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
    categories_link_tag.html_safe if current_user_is_admin
  end

  def new_category_for_admin
    new_category_link = "<li>#{link_to 'New category', new_category_path}</li>"
    new_category_link.html_safe if current_user_is_admin
  end
end
