require File.join( File.dirname( __FILE__ ), 'spec_helper.rb' )

describe Project do
  it "should not be valid without title" do
    p = Project.new
    p.should_not be_valid
  end
  
  it "should auto-create short_name" do
    p = Project.new( :title => 'An awesome project')
    p.valid?
    p.short_name.should == 'an_awesome_project'
  end
  
  context "saving to the database, and so on" do
    it "something" do
      p = Project.create!( :title => 'An awesome project' )
      t = Task.create!( :text => 'Something to do', :status => 'todo', :parent => p )
      p.should have(1).task
    end
  end
end