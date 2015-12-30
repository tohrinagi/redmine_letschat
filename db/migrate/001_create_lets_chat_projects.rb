class CreateLetsChatProjects < ActiveRecord::Migration
  def change
    add_column :projects, :lets_chat_url, :string, :default => "", :null => false
    add_column :projects, :lets_chat_token, :string, :default => "", :null => false
    add_column :projects, :lets_chat_room, :string, :default => "", :null => false
    add_column :projects, :lets_chat_notify_update, :boolean, :default => false, :null => false
  end
end
