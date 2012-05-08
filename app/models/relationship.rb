class Relationship < ActiveRecord::Base
  
  validates :parent_id, :presence => true
  validates :child_id, :presence => true
  
  belongs_to :parent, :class_name => "Task"
  belongs_to :child, :class_name => "Task", :dependent => :destroy
end
