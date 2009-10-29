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
  
  get '/?' do
    @page = Page.find_by_short_name( 'welcome' )
    haml :'pages/show', :layout => :new_layout
  end

  get '/pages/?' do
    layout = params[:embed].nil? ? true : false
    @pages = Page.find( :all )
    haml :'pages/list', :layout => layout
  end

  get '/pages/new' do
    layout = params[:embed].nil? ? true : false
    haml :'pages/new', :layout => layout
  end

  post '/pages/new' do
    @page = Page.new( params[:page] )
    success = @page.save
    @pages = Page.find( :all )
    haml :'pages/list', :layout => false
  end

  get '/pages/:short_name' do |short_name|
    layout = params[:embed].nil? ? true : false
    @page = Page.find_by_short_name( short_name )
    haml :'pages/show', :layout => layout
  end

  get '/pages/:short_name/tasks/new' do |short_name|
    layout = params[:embed].nil? ? true : false
    haml :'tasks/new', :layout => layout, :locals => { :task => Task.new, :short_name => short_name, :statuses => Task.chained_statuses }
  end

  post '/pages/:short_name/tasks/new' do |short_name|
    @page = Page.find_by_short_name( short_name )
    @page.tasks << Task.new( params[:task] )
    success = @page.save
    haml :'pages/show', :layout => false
  end

  # css
  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end

end
