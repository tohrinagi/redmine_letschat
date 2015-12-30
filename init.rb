Dir[File.expand_path('../lib/redmine_letschat', __FILE__) << '/*.rb'].each do |file|
  require_dependency file
end

Redmine::Plugin.register :redmine_letschat do
  name "Let's Chat Plugin for Redmine"
  author 'tohrinagi'
  description "This plugin sends message to your Let' Chat when issues are created."
  version '0.0.1'
  url 'https://github.com/tohrinagi/redmine_letschat'
  author_url 'http://tohrinagi.hatenablog.com'
end
