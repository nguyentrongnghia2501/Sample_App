
# app/models/user.rb
# Service to download ftp files from the server
# good
# frozen_string_literal: true

# Some documentation for Person
class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean
  end
end
