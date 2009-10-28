class Task
  include MongoMapper::EmbeddedDocument

  STATUSES = ['todo', 'later', 'waiting', 'done', 'cancel', 'report', 'smell', 'bug', 'fixed', 'invalid', 'question', 'answer', 'note']

  # Attributes
  key :text, String, :required => true
  key :tags, Array
  key :created_at, Time
  key :_type
  key :status, String, :required => true, :within => STATUSES

  # Associations
  # many :tasks
  # single level for now

  def self.statuses
    STATUSES
  end

end
