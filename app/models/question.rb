class Question < ActiveRecord::Base
  belongs_to :paper
  has_many :answers

  # ポイントと設問内容は必須 
  validates :point, :contents, presence: true

  # ポイントは数値で0以上
  validates :point, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0 }


  def getfilename question_id, user_id
  	source = Question.find(question_id).answers.find_by(user_id: user_id).source
  	if source
  		return source.src.path.split("/")[-1]
  	else
  		return "none"
  	end
  end
end
