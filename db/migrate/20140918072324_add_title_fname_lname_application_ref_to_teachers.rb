class AddTitleFnameLnameApplicationRefToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :title, :string
    add_column :teachers, :fname, :string
    add_column :teachers, :lname, :string
    add_reference :teachers, :application, index: true
  end
end
