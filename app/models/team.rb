class Team < ActiveRecord::Base
	belongs_to :application
	has_many :students
	MAX_STUDENT = 2

	def student_addable?
		self.students.count < MAX_STUDENT
	end
end
