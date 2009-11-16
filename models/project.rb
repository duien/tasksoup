class Project
  include MongoMapper::Document

  # Attributes
  key :title, String, :required => true
  key :tags, Array
  key :short_name, String, :unique => true, :required => true
  
  # Associations
  many :tasks, :as => :parent

  # Methods
  before_validation do |project|
    if project.short_name.nil? and not project.title.nil?
      project.short_name = project.title.underscore.gsub( /\s/, '_' )
    end
  end

end
