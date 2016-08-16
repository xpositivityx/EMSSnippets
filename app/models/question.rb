class Question < ActiveRecord::Base

	validates :stem, presence: true, length: { minimum: 5, maximum: 80 }
	validates :answer, :distractor1, :distractor2, :distractor3,
		:explaination, presence: true
	validate :four_unique_answers

	def new_call
		self.class.uncached do
			return Question.limit(1).order("RANDOM()").first()
		end
	end
	#custom validation for uniqueness

	def four_unique_answers
		array = [answer, distractor1, distractor2, distractor3]
		array.each_with_index do |v, k|
			a = array.delete_at(k)
			if array.include? v
				errors.add(v, "Questions require 4 unique options")
			end
			array.insert(k, v)
		end
	end

	def answered_correct
		self.correct ||= 0
		self.correct += 1
		self.save
	end

	def answered_incorrect
		self.correct ||= 0
		self.correct -= 1
		self.save
	end

	def difficulty
		x = Question.maximum('correct')
		y = Question.minimum('correct')
		z = self.correct
		if z == nil
			return 0
		else
			return range(x,y,z)
		end
	end

	private

	def range (old_min, old_max, value)
		old_range = (old_max - old_min)
		new_range = (10 - 1)
		new_min = 1
		new_value = (((value-old_min) * new_range) / old_range) + new_min
		return new_value
	end
end
