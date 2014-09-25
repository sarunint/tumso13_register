class Teacher < ActiveRecord::Base
	belongs_to :application
	validates :title, presence: true
	validates :fname, presence: true
	validates :lname, presence: true

	def full_name
		"#{title}#{fname} #{lname}"
	end
end
