class SourcesController < ApplicationController
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @sources = Source.all
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    @answer = Answer.find(@source.answer.id)
    if not current_user.roles.exists?(name: 'member') \
      or @answer.user_id == current_user.id then
      @cfile = @source.getSourcefile
    else
      redirect_to root_path, alert: "無効なURLです。"
    end
  end

  # GET /sources/new
  def new
    @answer = current_user.answers.where(question_id: params[:id]).first()
    if @answer.status == "UNDONE"
      @source = Source.new
      @source.answer = @answer
    else
      redirect_to assignment_path(@answer.assignment), alert: "すでに提出済です。"
    end
  end

  # GET /sources/1/edit
  def edit
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Source.new(source_params)

    respond_to do |format|
      if @source.filename_check and @source.save
        @answer = Answer.find(@source.answer_id)
        # ステータスを更新
        @question = Question.find(@answer.question_id)
        if @question.need_check == "なし"
          @answer.update(status: "DONE")
          power = current_user.increment(:fighting_power, @question.point)
          current_user.save
        else
          @answer.update(status: "UPLOAD")
        end

        format.html { redirect_to @source, notice: 'Source was successfully created.' }
        format.json { render :show, status: :created, location: @source }
      else
        @answer = Answer.find(@source.answer_id)
        format.html { render :new }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sources/1
  # PATCH/PUT /sources/1.json
  def update
    # 戦闘力の更新
    if (@source.answer.status == "UPLOAD" and source_params[:status] == "DONE") \
      or (@source.answer.status == "UPLOAD" and source_params[:status] == "DONE")
      u = @source.answer.user
      u.increment(:fighting_power, @source.answer.question.point)
      u.save
    end

    respond_to do |format|
      if @source.filename_check and @source.update(source_params)
        format.html { redirect_to @source, notice: 'Source was successfully updated.' }
        format.json { render :show, status: :ok, location: @source }
      else
        avatar = Source.find(@source).avatar
        @source.avatar = avatar
        @cfile = @source.getSourcefile(@source.avatar.path)
        format.html { render :template => "sources/show", :locals => { :source => @source, :cfile => @cfile } }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source.destroy
    respond_to do |format|
      format.html { redirect_to sources_url, notice: 'Source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_params
      params.require(:source).permit(:answer_id, :src)
    end
end
