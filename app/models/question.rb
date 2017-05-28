class Question < ActiveRecord::Base
  validates :problem, presence: true, length: {minimum: 3, maximum: 300}
  validates :answer, presence: true, length: {maximum: 50}
end