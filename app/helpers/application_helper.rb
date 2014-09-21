module ApplicationHelper
	def full_title(title)
		base_title = "การแข่งขันคณิตศาสตร์และวิทยาศาสตร์ระหว่างโรงเรียน ครั้งที่ 13"
		if title.empty?
			base_title
		else
			"#{base_title} | #{title}"
		end
	end
end
