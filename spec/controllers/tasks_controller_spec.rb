require 'spec_helper'

describe TasksController do

  before(:each) do
    @taskattr = {:title => "Test Title", :description => "Test description"}
  end
  
  describe "GET 'create'" do
    
    describe "failure"
    
    describe "success" do
      
      before(:each) do
        @task = Task.create!(:title => "parent")
        @childtask = @task.subtasks.create(:title => "child")
        @grandchildtask = @childtask.subtasks.create(:title => "grandchild")
      end
      
      it "should create a task" do
        lambda do
          post :create, :task => @taskattr
        end.should change(Task, :count).by(1)
      end
      
      it "should create a child task" do
        @childtask.subtasks.count.should == 1
        #expect {  # also tried lambda, but I must be doing the change().by(1) part wrong
          post :create, :task => @taskattr, :parent_id => @childtask.id
        #}.to change(@childtask.subtasks :count).by(1)
        @childtask.subtasks.count.should == 2
      end
      
      it "should create a sibling task" do
        @childtask.subtasks.count.should == 1
        @task.subtasks.count.should == 1
          post :create, :task => @taskattr, :after_id => @childtask.id
        @childtask.subtasks.count.should == 1
        @task.subtasks.count.should == 2
      end

    end

    describe "create subtasks" 

  end
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
      @task1 = Task.create!(:title => "task1", :description => "description1")
      @task2 = Task.create!(:title => "task2", :description => "description2")
    end
  
    it "should destroy the task" do 
      lambda do
        delete :destroy, :id => @task1.id
      end.should change(Task, :count).by(-1)
    end
    
  end 

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
