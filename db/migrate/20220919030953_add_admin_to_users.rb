# frozen_string_literal: true

# Service to download ftp files from the server
class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean
  end
end
