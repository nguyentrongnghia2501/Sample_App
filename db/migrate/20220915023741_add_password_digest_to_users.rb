# frozen_string_literal: true

# Service to download ftp files from the server
class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
  end
end
