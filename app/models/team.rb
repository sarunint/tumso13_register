class Team < ActiveRecord::Base
	belongs_to :application
	has_many :students
end
