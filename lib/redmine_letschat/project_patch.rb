module RedmineLetsChatProjects
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        safe_attributes 'lets_chat_url', 'lets_chat_token', 'lets_chat_room', 'lets_chat_notify_update'
      end
    end
  end
end

ActionDispatch::Reloader.to_prepare do
  unless Project.included_modules.include?(RedmineLetsChatProjects::ProjectPatch)
    Project.send(:include, RedmineLetsChatProjects::ProjectPatch)
  end
end
