class Application < ActiveRecord::Base
	belongs_to :school
	belongs_to :subject
	has_many :teams
	has_many :teachers
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true
	validates :status, presence: true
	has_secure_password
end
