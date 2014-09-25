class Application < ActiveRecord::Base
	belongs_to :school
	belongs_to :subject
	has_many :teams
	has_many :teachers
	has_many :sessions
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true
	validates :status, presence: true
	has_secure_password
	before_create :generate_token

	STATUS_TEXT = ['ไม่สังกัดโรงเรียน', 'ยังไม่ยืนยันอีเมล', 'ยังไม่ส่งเอกสาร', 'ได้รับเอกสารแล้ว']
	MAX_TEACHERS = 2
	MAX_TEAMS = 2
	def finalise
		errors = []
		addteam = false
		# Check teachers
		if self.teachers.empty?
			errors << :teacher
		end
		# Check teams
		if self.teams.empty?
			errors << :team
		end
		# Check team members
		self.teams.each do |t|
			if t.students.count != 2 and (not addteam)
				errors << t
				addteam = true
			end
		end
		errors
	end

	def status_text
		return STATUS_TEXT[self.status]
	end

	def teacher_addable?
		return self.teachers.count < MAX_TEACHERS
	end

	private
	def generate_token
		self.token = SecureRandom.urlsafe_base64
	end
end
