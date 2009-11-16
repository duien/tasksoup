require File.join( File.dirname( __FILE__ ), 'spec_helper.rb' )

describe Status do
#context "statuses" do
#  it 'should return array of statuses' do
#    Task.should have( 13 ).statuses
#    Task.statuses.each do |status|
#      [ 'todo', 'later', 'waiting', 'done', 'cancel', 'report', 'smell', 
#        'bug', 'fixed', 'invalid', 'question', 'answer', 'note' ].
#        should be_member( status )
#    end
#  end
#  
#  it 'should return array of chain names' do
#    Task.should have( 4 ).status_chains
#    Task.status_chains.each do |status|
#      [ 'task', 'bug', 'question', 'note' ].should be_member( status )
#    end
#  end
#  
#  it 'should return statuses for chain' do
#    Task.statuses(:chain => 'task').should have( 5 ).statuses
#    Task.statuses(:chain => 'task').each do |status|
#      [ 'todo', 'later', 'waiting', 'done', 'cancel' ].
#        should be_member( status )
#    end
#  end
#  
#  it 'should return statuses for type' do
#    Task.statuses(:type => 'pending').should have( 4 ).statuses
#    Task.statuses(:type => 'pending').each do |status|
#      [ 'later', 'waiting', 'smell', 'report' ].
#        should be_member( status )
#    end
#  end
#  
#  it 'should return statues for chain and type' do
#    Task.statuses(:type => 'inactive', :chain => 'question').should have(1).statuses
#    Task.statuses(:type => 'inactive', :chain => 'question').first.should == 'answer'
#  end
#  
#  it "should return chained statuses" do
#    chained = { 'task' => [ 'waiting', 'later', 'todo', 'done', 'cancel' ],
#                'bug' => [ 'report', 'smell', 'bug', 'fixed', 'invalid' ],
#                'question' => [ 'question', 'answer' ],
#                'note' => [ 'note' ]}
#    Task.chained_statuses.should == chained
#  end
#  
#end # context statuses
end