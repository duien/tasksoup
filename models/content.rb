class Content
  include MongoMapper::EmbeddedDocument

  key :text, String, :required => true
  key :tags, Array
  key :created_at, Time
  key :_type

end
