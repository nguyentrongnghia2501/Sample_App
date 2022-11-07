# good
# frozen_string_literal: true

# Some documentation for Person
class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
  end
end
