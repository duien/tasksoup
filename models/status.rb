class Status
  include MongoMapper::Document
  
  CHAINS = [ 'task', 'bug', 'question', 'note' ]
  TYPES = [ 'active', 'pending', 'inactive' ]
  
  key :name, String, :required => true, :unique => true
  key :chain, String,  :required => true, :within => CHAINS
  key :type, String,  :required => true, :within => TYPES
  key :position, Integer, :required => true, :numeric => true
  
  def self.chained
    CHAINS.inject({}){ |res,chain| res[chain] = find_all_by_chain(chain, :order => 'position'); res }
  end
end

## All possible task statuses
#def self.statuses( options = {} )
#  chain = options.delete( :chain )
#  type = options.delete( :type )
#  STATUSES.inject([]) do |statuses, (status, attributes)|
#    statuses.push status if (type.nil? or type == attributes[:type]) and (chain.nil? or chain == attributes[:chain])
#    statuses
#  end
#  #STATUSES.keys
#end
#
## The names of all status chains
#def self.status_chains
#  STATUSES.collect{ |status, attributes| attributes[:chain] }.flatten.uniq
#end
#
#def self.chained_statuses
#  status_chains.inject({}){ |res, chain| res[chain] = statuses( :chain => chain, :order => :position ); res }
#end
#STATUSES = {
#  'todo'     => { :chain => 'task', :type =>   'active', :position => 2 },
#  'later'    => { :chain => 'task', :type =>  'pending', :position => 1 },
#  'waiting'  => { :chain => 'task', :type =>  'pending', :position => 0 },
#  'done'     => { :chain => 'task', :type => 'inactive', :position => 3 },
#  'cancel'   => { :chain => 'task', :type => 'inactive', :position => 4 },
#
#  'report'   => { :chain => 'bug', :type =>  'pending', :position => 0 },
#  'smell'    => { :chain => 'bug', :type =>  'pending', :position => 1 },
#  'bug'      => { :chain => 'bug', :type =>   'active', :position => 2 },
#  'fixed'    => { :chain => 'bug', :type => 'inactive', :position => 3 },
#  'invalid'  => { :chain => 'bug', :type => 'inactive', :position => 4 },
#
#  'question' => { :chain => 'question', :type =>   'active', :position => 0 },
#  'answer'   => { :chain => 'question', :type => 'inactive', :position => 1 },
#
#  'note'     => { :chain => 'note', :type => 'note', :position => 0 }
#}