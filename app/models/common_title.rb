class CommonTitle < ActiveRecord::Base
	validates :title, presence: true
end
