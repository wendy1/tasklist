require 'spec_helper'

describe TasksController do
  render_views

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

  describe "GET 'edit'" do
    
    before(:each) do
      @task = Task.create!(@taskattr)
    end
    
    it "should be successful" do
      get :edit, :id => @task
      response.should be_successful
    end
    
    it "should have the right title" do
      get :edit, :id => @task
      response.should have_selector("title", :content => "Edit Task")
    end
    
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @task = Task.create!(@taskattr)
    end
    
    describe "success" do
      
      it "should change the task's complete attribute" do
        put :update, :id => @task, :task => { :complete => true }
        @task.reload
        @task.complete.should == true
        
        put :update, :id => @task, :task => { :complete => false }
        @task.reload
        @task.complete.should == false
      end
      
      it "should change the task's title attribute " do
        put :update, :id => @task, :task => { :title => "updated title" }
        @task.reload
        @task.title.should == "updated title"
      end
      
      it "should change the task's description attribute " do
        put :update, :id => @task, :task => { :description => "updated description" }
        @task.reload
        @task.description.should == "updated description"
      end
      
      pending "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      pending "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end

end
