class Student < ActiveRecord::Base
	belongs_to :team
	validates :title, presence: true
	validates :fname, presence: true
	validates :lname, presence: true
end
