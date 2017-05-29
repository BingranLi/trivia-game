class UsersController < ApplicationController
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Trivia Game #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to questions_path
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user_questions = @user.questions.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @users = User.order("score" + " " + "desc").paginate(page: params[:page], per_page: 10)
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def require_same_user
      if current_user != @user
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
     end
    end
end