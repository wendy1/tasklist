class Task < ActiveRecord::Base
  attr_accessible :title, :description
  
  validates :title, :presence => true
  
  has_many :relationships, :foreign_key => :parent_id, :dependent => :destroy
  has_many :subtasks, :through => :relationships, :source => :child
end
