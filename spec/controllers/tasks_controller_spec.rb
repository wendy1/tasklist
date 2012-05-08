require 'spec_helper'

describe TasksController do

  before(:each) do
    @taskattr = {:title => "Test Title", :description => "Test description"}
  end
  
  describe "GET 'create'" do
    
    describe "failure"
    
    describe "success" do
      
      it "should create a task" do
        lambda do
          post :create, :task => @taskattr
        end.should change(Task, :count).by(1)
      end

    end

    describe "create subtasks" 

  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
