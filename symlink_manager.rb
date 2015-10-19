require 'sinatra'
require './lib/directories_controller'

get "/" do
  @directories = DirectoriesController.index
  erb :index
end
