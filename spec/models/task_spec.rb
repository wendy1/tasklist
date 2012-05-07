require 'spec_helper'

describe Task do
  
  before(:each) do
    @taskattr = {:title => "Test Title", :description => "Test description"}
  end
  
  it "should create a new task" do
    task = Task.create!(@taskattr)
  end
  
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