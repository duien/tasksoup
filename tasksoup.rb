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
    @title = "TaskSoup / #{@project.title}"
    haml :'projects/show', :layout => layout
  end

  get '/projects/:short_name/tasks/new' do |short_name|
    layout = params[:embed].nil? ? true : false
    haml :'tasks/new', :layout => layout, :locals => { :task => Task.new, :short_name => short_name, :statuses => Status.chained }
  end

  post '/projects/:short_name/tasks/new' do |short_name|
    @project = Project.find_by_short_name( short_name )
    @project.tasks << Task.new( params[:task] )
    success = @project.save
    haml :'projects/show', :layout => false
  end
  
  get '/tasks/:id' do |id|
    @task = Task.find_by_id( id )
    if params[:only]
       content_type :json
      @task[params[:only]]
    else
      haml :'tasks/show', :layout => false, :locals => { :task => @task }
    end
  end
  
  post '/tasks/:id/edit' do |id|
    @task = Task.find_by_id( id )
    if params['task']['status'] == 'succ'
      @task.status = @task.status.succ
      @task.save
      @task.status.name
    else
      @task.update_attributes( params['task'] )
      if params['task']['text']
        haml :'util/maruku', :layout => false, :locals => { :text => params['task']['text'] }
      elsif params['task']['status_id']
        @task.status.name
      end
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
