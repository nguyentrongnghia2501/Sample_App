# frozen_string_literal: true

# Service to download ftp files from the server
class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: true
  end
end
