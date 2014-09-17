class Subject < ActiveRecord::Base
	has_and_belongs_to_many :schools
	has_many :applications
	validates :name, presence: true
end
