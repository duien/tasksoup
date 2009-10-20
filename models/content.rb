class Content
  include MongoMapper::EmbeddedDocument

  key :text, String, :required => true
  key :tags, Array
  key :_type
  key :created_at, Time

end
