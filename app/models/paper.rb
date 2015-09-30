class Paper < ActiveRecord::Base
	has_many :questions, dependent: :destroy
	has_many :assignments, dependent: :destroy

	validates :index, numericality: { greater_than: 0 }
	validates :index, uniqueness: true

  def count_questions
    return self.questions.length
  end
end
