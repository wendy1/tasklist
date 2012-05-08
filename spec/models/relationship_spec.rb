require 'spec_helper'

describe Relationship do
  
  describe "failure" do
    
    it "should require a parent_id" do
      badrelationship = Relationship.new(:parent_id => 1)
      badrelationship.should_not be_valid
    end
    it "should require a child_id" do
      badrelationship = Relationship.new(:child_id => 1)
      badrelationship.should_not be_valid
    end
    
  end
  
  describe "success" do
    
    before(:each) do
      @relattr = { :parent_id => 1, :child_id => 2 }
      @relationship = Relationship.new(@relattr)
    end
  
    it "should create a new relationship" do
      @relationship.should be_valid
    end
    
    it "should have a parent" do
      @relationship.should respond_to("parent")
    end
    
    it "should be able to add relationships to a task" do
      parenttask = Task.create!(:title => "a")
      parenttask.should be_valid
      childtask = Task.create!(:title => "b")
      relationship = parenttask.relationships.build(:child_id => childtask.id)
      relationship.should be_valid
      relationship.save!
      
      parenttask.relationships.count.should == 1
      parenttask.relationships.first.child_id.should == childtask.id
    end

  end
  
end
