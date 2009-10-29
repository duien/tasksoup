require 'sinatra/base'
require 'mongo_mapper'
require 'haml'
require 'sass'

base = File.dirname( __FILE__ )
Dir.glob( base + '/lib/*.rb' ).each { |f| require f }
Dir.glob( base + '/models/*.rb' ).each { |f| require f }

class TaskSoup < Sinatra::Base
  set :root, File.dirname( __FILE__ ) 
  enable :static
  
  configure do
    MongoMapper.database = 'tasksoup_dev'
  end

  get '/projects/?' do
    layout = params[:embed].nil? ? true : false
    @projects = Project.find( :all )
    haml :'projects/list', :layout => layout
  end

  get '/projects/new' do
    layout = params[:embed].nil? ? true : false
    haml :'projects/new', :layout => layout
  end

  post '/projects/new' do
    @project = Project.new( params[:project] )
    success = @project.save
    @projects = Project.find( :all )
    haml :'projects/list', :layout => false
  end

  get '/projects/:short_name' do |short_name|
    layout = params[:embed].nil? ? true : false
    @project = Project.find_by_short_name( short_name )
    haml :'projects/show', :layout => layout
  end

  get '/projects/:short_name/tasks/new' do |short_name|
    layout = params[:embed].nil? ? true : false
    haml :'tasks/new', :layout => layout, :locals => { :task => Task.new, :short_name => short_name, :statuses => Task.chained_statuses }
  end

  post '/projects/:short_name/tasks/new' do |short_name|
    @project = Project.find_by_short_name( short_name )
    @project.tasks << Task.new( params[:task] )
    success = @project.save
    haml :'projects/show', :layout => false
  end

  # css
  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end

end
