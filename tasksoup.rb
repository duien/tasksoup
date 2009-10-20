require 'sinatra/base'
require 'mongo_mapper'
require 'haml'

base = File.dirname( __FILE__ )
Dir.glob( base + '/lib/*.rb' ).each { |f| require f }
Dir.glob( base + '/models/*.rb' ).each { |f| require f }

class TaskSoup < Sinatra::Base
  set :root, File.dirname( __FILE__ ) 
  enable :static
  
  configure do
    MongoMapper.database = 'tasksoup_dev'
  end

  get '/pages/?' do
    layout = params[:embed].nil? ? true : false
    @pages = Page.find( :all )
    haml :'pages/list', :layout => layout
  end

  get '/pages/:short_name' do |short_name|
    layout = params[:embed].nil? ? true : false
    @page = Page.find_by_short_name( short_name )
    haml :'pages/show', :layout => layout
  end

  # css
  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end


  # helpers
  def haml_for( object )
    object_template = "#{object.type.to_s.tableize}/show".to_sym
    object_singular = object.type.to_s.underscore.to_sym
    haml object_template, :layout => false, :locals => { object_singular => object }
  end

end
