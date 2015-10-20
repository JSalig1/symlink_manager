require 'sinatra'
require 'singleton'
require './lib/directory'
require './lib/directories_controller'

get "/" do
  @directories = DirectoriesController.instance.index
  erb :index
end
