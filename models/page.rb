class Page
  include MongoMapper::Document

  # Attributes
  key :title, String, :required => true
  key :tags, Array
  key :short_name, String, :unique => true, :required => true
  
  # Associations
  many :contents, :polymorphic => true

  # Methods
  before_validation do |page|
    if page.short_name.nil? and not page.title.nil?
      page.short_name = page.title.underscore.gsub( /\s/, '_' )
    end
  end

end
