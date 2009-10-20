class Task
  include MongoMapper::EmbeddedDocument

  STATUSES = ['todo', 'later', 'waiting', 'done', 'cancel', 'report', 'smell', 'bug', 'fixed', 'invalid', 'question', 'answer']
  # Attributes
  key :status, String, :required => true, :within => STATUSES

  # Associations
  # many :contents, :polymorphic => true
  # single level for now

end
