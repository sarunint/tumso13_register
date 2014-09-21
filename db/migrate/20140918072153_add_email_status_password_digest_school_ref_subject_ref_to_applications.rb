class AddEmailStatusPasswordDigestSchoolRefSubjectRefToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :email, :string
    add_column :applications, :status, :integer
    add_column :applications, :password_digest, :string
    add_reference :applications, :school, index: true
    add_reference :applications, :subject, index: true
  end
end
