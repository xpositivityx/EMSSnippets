class QuestionsController < ApplicationController
  before_action :is_admin, only: [:edit,:update,:destroy,:index]

  def index
    @questions = Question.all.order(id: :asc)
    render :index
  end

  def new
  	render :new
  end

  def filter
    @topic = params[:topic]
    @sort = params[:sort]
    @questions = Question.where("questions.topic = '#{@topic}' OR questions.subtopic1 = '#{@topic}' OR questions.subtopic2 = '#{@topic}'").order("#{@sort} ASC")
    render :index
  end

  def create
  	@q = Question.new
  	@q.stem = params[:stem]
    @q.image = params[:image]
  	@q.answer = params[:answer]
  	@q.distractor1 = params[:distractor1]
  	@q.distractor2 = params[:distractor2]
  	@q.distractor3 = params[:distractor3]
  	@q.explaination = params[:explaination]
    @q.topic = params[:tag1]
    @q.subtopic1 = params[:tag2]
    @q.subtopic2 = params[:tag3]
  	if !@q.save
  		flash[:notice] = "Question Not Saved"
  	else
  		@q.save
  		flash[:notice] = "Question Saved Successfully"
  	end
  	render :new 
  end
  
  def edit
    @question = Question.find(params[:id])
    @array = ['Vocabulary', 'Anatomy', 'Navigation', 'Organs']
    @lam = lambda do |array, model, tag|
      final = ''
      array.each do |y|
        if y.downcase == model.send(tag).downcase
          final << "<option selected='selected'> " + model.send(tag) +
          " </option>"
        else
          final << "<option> " + y + " </option>"
        end
      end
      return final
    end

    render :edit
  end

  def update
    @q = Question.find(params[:id])
    @q.stem = params[:stem]
    @q.image = params[:image]
    @q.answer = params[:answer]
    @q.distractor1 = params[:distractor1]
    @q.distractor2 = params[:distractor2]
    @q.distractor3 = params[:distractor3]
    @q.explaination = params[:explaination]
    @q.topic = params[:tag1]
    @q.subtopic1 = params[:tag2]
    @q.subtopic2 = params[:tag3]
    if !@q.save
      flash[:notice] = "Question Not Updated"
      redirect_to "/questions/#{@q.id}/edit"
    else
      @q.save
      flash[:notice] = "Question Updated Successfully"
      redirect_to questions_url
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.delete
    redirect_to questions_path
  end

  private

  def is_admin
    unless session[:is_admin]
      flash[:notice] = 'you must be admin to access this area'
      redirect_to test_index_path
    end
  end

end
