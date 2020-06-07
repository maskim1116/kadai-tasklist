class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :show]
  
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new 
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to task_path(@task)
    else
      flash.now[:danger] ='Taskが投稿されませんでした'
      render :new
    end
  end
  
  def edit 
    @task = Task.find(params[:id])
  end
  
  def update 
    @task =Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to task_path(@task)
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
    
  end
  
  def destroy 
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(Id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
