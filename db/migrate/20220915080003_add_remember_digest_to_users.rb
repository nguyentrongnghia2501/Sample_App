# good
# frozen_string_literal: true

# Some documentation for Person
class AddRememberDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :remember_digest, :string
  end
end
