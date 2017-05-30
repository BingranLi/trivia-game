class Question < ActiveRecord::Base
  belongs_to :user
  has_many :question_categories
  has_many :categories, through: :question_categories
  validates :problem, presence: true, length: {minimum: 3, maximum: 300}
  validates :answer, presence: true, length: {maximum: 50}
end