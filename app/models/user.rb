class User < ActiveRecord::Base

	has_secure_password
	after_initialize :init

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email, presence: true, uniqueness: true, 
	format: {with: EMAIL_REGEX, message: 'Must use valid email'}
	validates :name, presence: true, format: {with: /\w+\s\w+/i}

	def init
		self.questions_correct ||= ''
		self.correct_count ||= 0
	end

	def send_password_reset
		generate_token(:password_reset)
		self.password_reset_sent = Time.now
		save!
		UserMailer.passwordreset(self).deliver
	end

	def send_welcome_email
		UserMailer.welcome_email(self).deliver
	end

	def generate_token(column)
			self[column] = SecureRandom.urlsafe_base64
	end

	def correct (id)
		query = self.questions_correct
		self.correct_count += 1
		if query.instance_of? String
				if !query.include?(",#{id},")
					self.questions_correct = "#{self.questions_correct},#{id},"
				end
		else
			self.questions_correct = ",#{id},"
		end
		self.save
	end

	def percentage_correct
		x = Question.count 
		if self.correct_count < x
			return ((self.correct_count.to_f / x.to_f ) * 100).to_i
		else
			return 100
		end
	end

end
