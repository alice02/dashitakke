class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @source = Source.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.paper_id = params[:paper_id]
    @paper = Paper.find(params[:paper_id])

    respond_to do |format|
     if @question.save
       format.html { redirect_to controller: :papers,
                                 action: :show,
                                 :id => params[:paper_id],
                                 notice: 'Question was successfully created.' }
        # TODO: noticeが表示されない
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :template=> "papers/show", :locals => { :paper => @paper } }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to controller: :papers,
                                  action: :show,
                                  :id => @question.paper_id,
                                  notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    paper_id = @question.paper_id
    @question.destroy
    # indexを振り直す
    @questions = Question.where(paper_id: paper_id)
    @questions.each_with_index do |q, i|
      q.update(:index => (i+1))
    end
    respond_to do |format|
      format.html { redirect_to controller: :papers, action: :show, :id => @question.paper_id, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:index, :need_check, :point, :contents, :paper_id, :extension, :mime)
    end
end
