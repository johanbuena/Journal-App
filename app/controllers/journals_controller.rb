class JournalsController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :set_journal, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [ :show, :edit, :update, :destroy]

  def index
    @journals = current_user.journals.all
    @tasks = current_user.tasks.all
  end

  def new
    # @journal = Journal.new
    @journal = current_user.journals.build
  end

  def create
    # @journal = Journal.new(journal_params)
    @journal = current_user.journals.build(journal_params)

    respond_to do |format|
      if @journal.save
        format.html { redirect_to journals_path, notice: "Journal was successfully created." }
        format.json { render :index, status: :created, location: @Journal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    
  end

  def edit
    # @task = @journal.tasks.find(params[:id])
  end

  # PATCH/PUT /journals/1 or /journals/1.json
  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to journals_path, notice: "journal was successfully updated." }
        format.json { render :index, status: :ok, location: @journal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journals/1 or /journals/1.json
  def destroy
      if @journal.destroy
        @journal.tasks.destroy_all
        respond_to do |format|
          format.html { redirect_to journals_path, notice: "journal was successfully destroyed." }
          format.json { head :no_content }
        end
      end
  end

  def correct_user
    # @journal = current_user.journals.find_by(id: params[:id])
    # redirect_to journals_path if @journal.nil?
    if current_user.id == @journal.user_id
      return true
    else
      redirect_to journals_path
    end 
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def journal_params
      params.require(:journal).permit(:user_id, :journal_name, :journal_description)
    end
end
