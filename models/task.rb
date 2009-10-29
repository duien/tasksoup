class Task
  include MongoMapper::EmbeddedDocument

  STATUSES = { 'task'     => [ 'todo', 'later', 'waiting', 'done', 'cancel' ],
               'bug'      => [ 'report', 'smell', 'bug', 'fixed', 'invalid' ], 
               'question' => [ 'question', 'answer' ],
               'note'     => [ 'note' ] }
  def self.statuses
    STATUSES.values.flatten
  end

  # Attributes
  key :text, String, :required => true
  key :tags, Array
  key :created_at, Time
  key :status, String, :required => true, :within => statuses

  # Associations
  # many :tasks
  # single level for now

  # def self.statuses
  #   STATUSES.values.flatten
  # end

  def self.status_chains
    STATUSES.keys
  end

  def self.chained_statuses
    STATUSES
  end

end
