class TasksController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :set_journal
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [ :show, :edit, :update, :destroy, :create]
  def index
    @tasks = current_user.tasks.all
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @journal, notice: "task was successfully created." }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # PATCH/PUT /journals/1 or /journals/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
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
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @journal, notice: "journal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def changeTaskStatus
  #   respond_to do |format|
  #     if @task.taskstatus == false
  #       @task.taskstatus == true
  #       @task.update
  #       redirect_to @journal
  #     else
  #       @task.taskstatus == false
  #       @task.update
  #       redirect_to @journal
  #     end
  #   end
  # end

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
      @journal = Journal.find(params[:journal_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:journal_id, :user_id, :taskname, :taskdescription, :taskdeadline, :taskstatus)
    end
end
