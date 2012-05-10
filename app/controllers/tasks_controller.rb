class TasksController < ApplicationController
  
  def index
    @title = "Task list"
    @tasks = Task.find :all, :conditions => 'id NOT IN (select distinct child_id from relationships)'
    Rails::logger.info "------------------ @task ids are"
    @tasks.each do |t|; Rails::logger.info t.id.to_s; end
    Rails::logger.info "--------------------"
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
