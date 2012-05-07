class TasksController < ApplicationController
  
  def index
    @title = "Task list"
    @tasks = Task.all
  end
  
  def new
    @title = "New task"
    @task = Task.new
  end
  
  def create
    @task = Task.new(params[:task])
    @task.save
    redirect_to root_path
  end

  def show
  end
end
