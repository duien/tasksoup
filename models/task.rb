class Task
  include MongoMapper::EmbeddedDocument

  STATUSES = {
    'todo'     => { :chain => 'task', :type =>   'active', :position => 2 },
    'later'    => { :chain => 'task', :type =>  'pending', :position => 1 },
    'waiting'  => { :chain => 'task', :type =>  'pending', :position => 0 },
    'done'     => { :chain => 'task', :type => 'inactive', :position => 3 },
    'cancel'   => { :chain => 'task', :type => 'inactive', :position => 4 },

    'report'   => { :chain => 'bug', :type =>  'pending', :position => 0 },
    'smell'    => { :chain => 'bug', :type =>  'pending', :position => 1 },
    'bug'      => { :chain => 'bug', :type =>   'active', :position => 2 },
    'fixed'    => { :chain => 'bug', :type => 'inactive', :position => 3 },
    'invalid'  => { :chain => 'bug', :type => 'inactive', :position => 4 },

    'question' => { :chain => 'question', :type =>   'active', :position => 0 },
    'answer'   => { :chain => 'question', :type => 'inactive', :position => 1 },

    'note'     => { :chain => 'note', :type => 'note', :position => 0 }
  }

  # Attributes
  key :text, String, :required => true
  key :tags, Array
  key :created_at, Time
  key :status, String, :required => true, :within => STATUSES.keys
  
  # All possible task statuses
  def self.statuses( options = {} )
    chain = options.delete( :chain )
    type = options.delete( :type )
    STATUSES.inject([]) do |statuses, (status, attributes)|
      statuses.push status if (type.nil? or type == attributes[:type]) and (chain.nil? or chain == attributes[:chain])
      statuses
    end
    #STATUSES.keys
  end

  # The names of all status chains
  def self.status_chains
    STATUSES.collect{ |status, attributes| attributes[:chain] }.flatten.uniq
  end

  def self.chained_statuses
    
  end

end
