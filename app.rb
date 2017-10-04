require 'sinatra'
require 'csv'
require_relative 'lib/CountryDBManager.rb'
require_relative 'lib/CountryEntry.rb'
require_relative 'lib/CountryDBReader.rb'
require_relative 'lib/CountryNameManager.rb'
require_relative 'lib/ViewDataController.rb'

set :bind, '0.0.0.0'


EXPORTER = CountryDBManager.new

DB_NAME = 'intermaps_db_dev'
DB_IP = 'localhost'

DB_UNAME = 'postgres'
DB_PASSWD = 'postgres'



#Home
get '/' do
	erb :home
end


#Upload data routes
get '/upload/exports' do
	erb :upload_exports
end

get '/upload/imports' do
	erb :upload_imports
end

post '/upload/exports' do
	EXPORTER.import_csv(params['file'][:tempfile], "exports");
	erb :upload_exports
end

post '/upload/imports' do
	EXPORTER.import_csv(params['file'][:tempfile], "imports")
	erb :upload_imports
end


#View data routes
get '/viewdata' do
	erb :viewdata, :locals => {:showingdata => false}
end

post '/viewdata' do
	ctrl = ViewDataController.new
	reader = CountryDBReader.new
	name_manager = CountryNameManager.new

	data = reader.get_data params[:action], params[:article], params[:since_year], 
														params[:since_month], params[:until_year], params[:until_month],
														params[:country]
	
	red_data = ctrl.reduce_data(data)
	red_data2 = ctrl.reduce_data2(data)
	erb :viewdata, :locals => {:results => data, :showingdata => true, :reduced_data => red_data, :reduced_data2 => red_data2}
end
