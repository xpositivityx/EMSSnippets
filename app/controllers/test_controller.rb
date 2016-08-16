class TestController < ApplicationController

  def index
  	#@question = Question.find(rand(Question.count))
  	@question = Question.limit(1).order("RANDOM()").first()
  	@user = User.find(session[:user_id])

    lam = lambda do ||
      while @user.questions_correct.include?(",#{@question.id},")
        @question = @question.new_call
      end
    end

    if @user.percentage_correct < 1.0
      lam.call
    end

    render 'index'
  end

  def correct
  	u = User.find(params[:id])
    q = Question.find(params[:question])
    q.answered_correct
  	u.correct(params[:question])
    render nothing: true
  end

  def incorrect
  	u = User.find(params[:id])
    q = Question.find(params[:question])
  	q.answered_incorrect
  	u.correct(params[:question])
    render nothing: true
  end

end
