class Task < Content

  STATUSES = ['todo', 'later', 'waiting', 'done', 'cancel', 'report', 'smell', 'bug', 'fixed', 'invalid', 'question', 'answer', 'note']
  # Attributes
  key :status, String, :required => true, :within => STATUSES

  # Associations
  # many :contents, :polymorphic => true
  # single level for now

  def self.statuses
    STATUSES
  end

end
