require 'mongo_mapper'

MongoMapper.database = 'tasksoup-model-test'

# class Parent
#   include MongoMapper::Document
#   many :tasks
# end

class Project #< Parent
  include MongoMapper::Document
  key :title, String, :required => true
  many :tasks, :foreign_key => :parent_id
end

class Task #< Parent
  include MongoMapper::Document
  key :text, String, :required => true
  key :status, String, :required => true
  key :parent_id, String
  key :parent_type, String
  many :tasks, :foreign_key => :parent_id

  belongs_to :parent, :polymorphic => true

  def project
    if self.parent_type == 'Project'
      self.parent
    else
      self.parent.project
    end
  end
end
