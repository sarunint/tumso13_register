class Session < ActiveRecord::Base
	belongs_to :application
	validates :remember_token, presence: true

	def self.generate_token
		SecureRandom.urlsafe_base64
	end
end
