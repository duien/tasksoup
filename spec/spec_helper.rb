$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'mongo_mapper'
require 'models/project'
require 'models/task'

Spec::Runner.configure do |config|
  Mongo::Connection.new.drop_database('tasksoup_test')
  MongoMapper.database = 'tasksoup_test'
end