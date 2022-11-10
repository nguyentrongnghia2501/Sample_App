# good
# frozen_string_literal: true

# Some documentation for Person
# Service to download ftp files from the server
class AddResetToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
