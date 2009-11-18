require 'sinatra/base'
gem 'mongo_mapper', '~> 0.6.0'
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
    @title = ' / ' + @project.title
    haml :'projects/show', :layout => layout
  end
  
  get '/projects/:short_name/tasks/new' do |short_name|
    @submit_to = '/tasks/new'
    layout = params[:embed].nil? ? true : false
    task = Task.new
    task.parent = Project.find_by_short_name(short_name)
    haml :'tasks/new', :layout => layout, :locals => { :task => task, :statuses => Status.chained }
  end
  
  get '/tasks' do
    layout = params[:embed].nil? ? true : false
    find_params = {}
    find_params[:parent_type] = 'Project' unless params[:nested] = false
    find_params[:status_id] = params[:status].collect{ |s| Status.find_by_name(s)._id } if params[:status]
    @show_parent = true
    @tasks = Task.all( find_params )
    haml :'tasks/list', :layout => layout
  end

  get '/tasks/new' do
    @submit_to = '/tasks/new'
    layout = params[:embed].nil? ? true : false
    haml :'tasks/new', :layout => layout, :locals => { :task => Task.new( params['task']), :statuses => Status.chained }
  end

  post '/tasks/new' do
    task = Task.new( params['task'] )
    haml :'tasks/show', :layout => false, :locals => { :task => task }
  end
  
  get '/tasks/:id' do |id|
    task = Task.find_by_id( id )
    if params[:only]
       content_type :json
      task[params[:only]]
    else
      haml :'tasks/show', :layout => false, :locals => { :task => task }
    end
  end
  
  get '/tasks/:id/edit' do |id|
    @submit_to = "/tasks/#{id}/edit"
    task = Task.find_by_id( id )
    haml :'tasks/new', :layout => false, :locals => { :task => task, :statuses => Status.chained }
  end
  
  post '/tasks/:id/edit' do |id|
    task = Task.find_by_id( id )
    if params['task']['status'] == 'succ'
      task.status = task.status.succ
      task.save
      task.status.name
    elsif params['cancel']
      haml :'tasks/show', :layout => false, :locals => { :task => task }
    else
      task.parent_id = Mongo::ObjectID.from_string( params['task'].delete('parent_id') ) if params['task']['parent_id']
      task.update_attributes( params['task'] )
      haml :'tasks/show', :layout => false, :locals => { :task => task }
    end
  end
  
  get '/statuses/chained' do
    content_type :json
    Status.all.inject({}){ |res, s| res[s.id] = s.name; res }.to_json
  end

  # css
  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end

end
