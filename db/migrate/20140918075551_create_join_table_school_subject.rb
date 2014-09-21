class CreateJoinTableSchoolSubject < ActiveRecord::Migration
  def change
    create_join_table :schools, :subjects do |t|
      # t.index [:school_id, :subject_id]
      # t.index [:subject_id, :school_id]
    end
  end
end
