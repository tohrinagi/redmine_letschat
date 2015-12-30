module RedmineLetsChatProjects
  class LetsChatListener < Redmine::Hook::Listener
    def controller_issues_new_after_save(context={})
      issue = context[:issue]
      project = issue.project

      return if issue.is_private?
      return if !configured?(project)

      msg = "[#{I18n.t(:lets_chat_caption_issues_new)}][#{escape(issue.project)}] <#{escape(issue)}>\n" +
      "#{I18n.t(:lets_chat_caption_url)} : #{get_url(issue)}\n" +
      "#{I18n.t(:lets_chat_caption_priority)} : #{escape(issue.priority.to_s)}\n" +
      "#{I18n.t(:lets_chat_caption_author)} : #{escape(issue.author)}\n" +
      "#{I18n.t(:lets_chat_caption_assigned_to)} : #{escape(issue.assigned_to.to_s)}\n"

      data = {}
      data[:msg] = msg
      data[:url] = project.lets_chat_url
      data[:token] = project.lets_chat_token
      data[:room] = project.lets_chat_room

      send_message( data )
    end

    def controller_issues_edit_after_save(context = {})
      issue = context[:issue]
      project = issue.project

      return if issue.is_private?
      return if !configured?(project)
      return if !project.lets_chat_notify_update

      msg = "[#{I18n.t(:lets_chat_caption_issues_edit)}][#{escape(issue.project)}] <#{escape(issue)}>\n" +
      "#{I18n.t(:lets_chat_caption_url)} : #{get_url(issue)}\n" +
      "#{I18n.t(:lets_chat_caption_priority)} : #{escape(issue.priority.to_s)}\n" +
      "#{I18n.t(:lets_chat_caption_author)} : #{escape(issue.author)}\n" +
      "#{I18n.t(:lets_chat_caption_assigned_to)} : #{escape(issue.assigned_to.to_s)}\n"

      data = {}
      data[:msg] = msg
      data[:url] = project.lets_chat_url
      data[:token] = project.lets_chat_token
      data[:room] = project.lets_chat_room

      send_message( data )
    end

    private
    def configured?(project)
      if !project.lets_chat_url.empty? && !project.lets_chat_token.empty? && !project.lets_chat_room.empty?
        true
      else
        false
      end
    end

    def send_message(data)
      params = {}
      params[:text] = data[:msg]
      params[:room] = data[:room]

      url = URI.join(data[:url],"/messages")
      request = Net::HTTP::Post.new(url.path)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "Bearer #{data[:token]}"
      request.body = params.to_json
      response = Net::HTTP.start(url.host, url.port) {|http| http.request(request) }
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
      else
        #p response
        #exit 1
      end
    end

    def escape(msg)
      msg.to_s.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;")
    end

    def get_url(obj)
      Rails.application.routes.url_for(obj.event_url({:host => Setting.host_name, :protocol => Setting.protocol}))
    end

  end
end
