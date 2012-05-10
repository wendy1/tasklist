require 'spec_helper'

describe Task do
  
  before(:each) do
    @taskattr = {:title => "Test Title", :description => "Test description"}
  end
  
  describe "failure" do
    
    it "should require a title" do
      errtask = Task.new(@taskattr.merge(:title => ""))
      errtask.should_not be_valid
    end
    
    it "should be able to create 2 tasks in the database" do
      task1 = Task.create!(@taskattr)
      Task.all.count.should == 1

      task2 = Task.create!(@taskattr.merge(:title => "Title2"))
      tasks = Task.all
      tasks.count.should == 2
      tasks.should include(task1)
      tasks.should include(task2)
    end
    
  end
  
  describe "success" do
    
    before(:each) do
      @task = Task.create(@taskattr)
    end
    
    it "should create a valid task" do
      @task.should be_valid
    end
    
    it "should have relationships" do
      @task.should respond_to("child_relationships")
    end
    
    it "should have subtasks" do
      @task.should respond_to("subtasks")
    end
    
    it "sho
    uld start with zero subtasks" do
      @task.subtasks.count.should == 0
    end
    
    it "should be able to add child relationships" do
      subtask = Task.create(:title => "subtask1")
      child_relationship = @task.child_relationships.build(:child_id => subtask.id)
      child_relationship.should be_valid
      child_relationship.save!
      @task.subtasks.count.should == 1 
    end
    
    it "should be able to add subtasks" do
      @task.subtasks.create!(:title => "subtask1")
      @task.subtasks.create!(:title => "subtask2")
      @task.subtasks.count.should == 2
      Task.all.count.should == 3
    end
    
    it "should destroy child tasks when parent is destroyed" do
      # make the 2 subtasks (again)
      @task.subtasks.create!(:title => "subtask1")
      @task.subtasks.create!(:title => "subtask2")
      @task.subtasks.count.should == 2
      Task.all.count.should == 3
      
      # and now delete the parent task
      @task.destroy
      Task.all.count.should == 0
    end
    
  end
  
  describe "parent relationships" do
    
    before(:each) do
      @task = Task.create(@taskattr)
      @subtask = @task.subtasks.create(:title => "subtask")
      @subsubtask = @subtask.subtasks.create(:title => "subsubtask")
    end
    
    it "should not have a parent if it's not a subtask" do
      @task.parent.should be_nil
    end
    
    it "should have a parent if it's a subtask" do
      @subtask.parent.should == @task
      @subsubtask.parent.parent.should == @task
    end
  end  
  
end