$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'mongo_mapper'
require 'models/project'
require 'models/task'

Spec::Runner.configure do |config|
  
end