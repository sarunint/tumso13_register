class AddTitleFnameLnameTeamRefToStudents < ActiveRecord::Migration
  def change
    add_column :students, :title, :string
    add_column :students, :fname, :string
    add_column :students, :lname, :string
    add_reference :students, :team, index: true
  end
end
