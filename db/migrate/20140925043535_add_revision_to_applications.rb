class AddRevisionToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :revision, :integer
  end
end
