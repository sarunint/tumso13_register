class AddNameToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :name, :string
  end
end
