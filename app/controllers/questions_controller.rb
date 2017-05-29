class QuestionsController < ApplicationController
  before_action :require_user, except: [:index]
 # before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:success] = "Question was successfully created"
      redirect_to question_path(@question)
    else
      render 'new'
    end
  end
  
  def show
    @question = Question.find(params[:id])
    if current_user != @question.user
      @response = Question.new
    end
  end
  
  def index
    @questions = Question.paginate(page: params[:page], per_page: 5)
  end
  
  def answer
    @question = Question.find(params[:id])
    @response = Question.new(question_params)
    is_correct = compare_answer(@question.answer, @response.answer)
    score = 0
    if is_correct
      score = 4
      flash[:success] = "Correct! ths answer is #{@question.answer}"
    else
      score = -1
      @question.errors.add(:answer, "Invalid");
    end
    user = User.find(current_user.id)
    user.update_attribute(:score, user.score + score)
    # redirect_to 'show'
  end

  private
    def question_params
      params.require(:question).permit(:problem, :answer)
    end
    
    def compare_answer(answer, origin)
      return answer == origin
    end
end