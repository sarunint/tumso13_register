class AddRememberTokenApplicationRefToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :remember_token, :string
    add_reference :sessions, :application, index: true
  end
end
