require File.join( File.dirname( __FILE__ ), 'spec_helper.rb' )

describe Task do
  context "subtasks" do
    it "something" do
      t = Task.create( :text => 'Something to do', :status => 'todo')
      t.should have(0).tasks
      t2 = Task.create( :text => 'Subtask', :status => 'todo' )
      t.tasks << t2
      t.save
      t.should have(1).task
    end
  end # context subtasks
end # describe Task
