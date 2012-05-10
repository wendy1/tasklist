class TasksController < ApplicationController
  
  def index
    @title = "Task list"
    @tasks = Task.find :all, :conditions => 'id NOT IN (select distinct child_id from relationships)'
  end
  
  def new
    @title = "New task"
    
    unless (params[:after_id].nil?)
      # add a sibling task
      @existing_task = Task.find_by_id(params[:after_id])
      unless @existing_task.parent.nil?
        @task = @existing_task.parent.subtasks.new
      else
        @task = Task.new
      end
    else
      # add subtask
      unless (params[:parent_id].nil?)
        @task = Task.find_by_id(params[:parent_id]).subtasks.new
      else
        @task = Task.new
      end
    end
  end
  
  def create
    parent = params[:parent_id]
    after = params[:after_id]
    
    unless parent.nil? || parent==""
      # make a child task
      @task = Task.find_by_id(parent).subtasks.create(params[:task])
    else
      unless after.nil?
        # make a sibling task
        @existing_task = Task.find_by_id(params[:after_id])
      
        # check if top level task
        unless @existing_task.parent.nil?
          #n on-top level - make a child task of the same parent
          @task = @existing_task.parent.subtasks.create(params[:task])
        else
          # top level task
          @task = Task.create(params[:task])
        end
      else
        # Just make a generic task
        @task = Task.create(params[:task])
      end

    end
    redirect_to root_path
  end

  def show
  end
  
  def destroy
    Task.destroy(params[:id])
    redirect_to root_path
  end
  
end
