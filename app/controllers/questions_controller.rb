class QuestionsController < ApplicationController
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user = User.first
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