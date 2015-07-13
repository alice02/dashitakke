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
    @cfile = @source.getSourcefile(@source.filepath)
  end

  # GET /sources/new
  def new
    @source = Source.new
  end

  # GET /sources/1/edit
  def edit
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Source.new(source_params)
    filename = source_params[:avatar].original_filename
    save_dir_path = "#{Rails.root}/public/source_code/" + "j" + current_user.number.to_s[0..1] + "/j" + current_user.number.to_s.delete("-") + "/"
    @source.filepath = save_dir_path + filename

    respond_to do |format|
      if @source.save
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
        assignment_id = Answer.find(@source.answer_id).assignment_id
        @assignment = Assignment.find(assignment_id)
        format.html { render :template => "assignments/show", :locals => { :assignment => @assignment } }
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

    # 保存先ファイル名の更新
    filename = source_params[:avatar].original_filename
    save_dir_path = "#{Rails.root}/public/source_code/" + "j" + current_user.number.to_s[0..1] + "/j" + current_user.number.to_s.delete("-") + "/"
    @source.filepath = save_dir_path + filename

    respond_to do |format|
      if @source.update(source_params)
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
      params.require(:source).permit(:answer_id, :avatar)
    end
end
