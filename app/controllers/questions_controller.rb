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
  end
  
  def index
    @questions = Question.paginate(page: params[:page], per_page: 5)
  end

  private
    def question_params
      params.require(:question).permit(:problem, :answer)
    end
end