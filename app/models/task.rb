class Task < ActiveRecord::Base
  attr_accessible :title, :description
  
  validates :title, :presence => true
  
  # define subtasks as child relationships
  has_many :child_relationships, 
    :class_name => "Relationship",
    :foreign_key => :parent_id, 
    :dependent => :destroy
  has_many :subtasks, 
    :through => :child_relationships,
    :source => :child
    
  # define parenttasks as parent relationships
  has_one :parent_relationships,
    :class_name => "Relationship",
    :foreign_key => :child_id
  has_one :parent,
  :through => :parent_relationships,
  :source => :parent
end
