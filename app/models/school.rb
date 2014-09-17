class School < ActiveRecord::Base
	has_many :applications
	has_and_belongs_to_many :subjects
	validates :name, presence: true, uniqueness: true
	validates :number, presence: true
	validates :soi, presence: true
	validates :road, presence: true
	validates :subdistrict, presence: true
	validates :district, presence: true
	validates :province, presence: true
	validates :zip, presence: true
	validates :telephone, presence: true
	validates :fax, presence: true
	validates :website, presence: true
end
