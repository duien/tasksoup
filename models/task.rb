class Task
  include MongoMapper::Document

  # Attributes
  key :text, String, :required => true
  key :tags, Array
  key :created_at, Time
  key :status_id, Mongo::ObjectID
  
  # Association keys
  key :parent_id, Mongo::ObjectID
  key :parent_type
  
  #Associations
  belongs_to :parent, :polymorphic => true
  many :tasks, :as => :parent
  belongs_to :status
  
  def project
    parent_type == 'Project' ? parent : parent.project
  end

end
