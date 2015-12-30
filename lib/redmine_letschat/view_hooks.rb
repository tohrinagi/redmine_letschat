module RedmineLetsChatProjects
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_projects_form, partial: 'projects/hook_view_projects_form'
  end
end
