class School < ActiveRecord::Base
	has_many :applications
	has_and_belongs_to_many :subjects
	validates :name, presence: true, uniqueness: true
	validates :number, presence: true
	# validates :soi, presence: true
	validates :road, presence: true
	validates :subdistrict, presence: true
	validates :district, presence: true
	validates :province, presence: true
	validates :zip, presence: true
	validates :telephone, presence: true
	# validates :fax, presence: true
	# validates :website, presence: true

	def full_address
		res = []
		res << number
		if not soi.blank? and soi != '-'
			res << "ซอย#{soi}"
		end
		res << "ถนน#{road}"
		if province.include? 'กรุงเทพ'
			res << "แขวง#{subdistrict}"
			res << "เขต#{district}"
		else
			res << "ตำบล#{subdistrict}"
			res << "อำเภอ#{district}"
		end
		res << "จังหวัด#{province}"
		res << zip
		res.join " "
	end

	def contact_information
		res = []
		res << "โทรศัพท์ #{telephone}"
		if not fax.blank? and fax != '-'
			res << "โทรสาร #{fax}"
		end
		res.join " "
	end
end
