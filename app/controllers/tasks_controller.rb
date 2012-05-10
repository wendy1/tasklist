class TasksController < ApplicationController
  
  def index
    @title = "Task list"
    @tasks = Task.find :all, :conditions => 'id NOT IN (select distinct child_id from relationships)'
  end
  
  def new
    @title = "New task"
    if (params[:parent_id] != nil)
      @task = Task.find_by_id(params[:parent_id]).subtasks.new
    else
      @task = Task.new
    end
  end
  
  def create
    parent = params[:parent_id]
    Rails::logger.info "========= parent="+ (parent.nil? ? "nil" :  parent) 
    unless parent.nil?
      @task = Task.find_by_id(parent).subtasks.create(params[:task])
    else
      @task = Task.create(params[:task])
    end
    redirect_to root_path
  end

  def show
  end
end
