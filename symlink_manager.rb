require 'sinatra'
require 'singleton'
require './lib/directory'
require './lib/directories_controller'

get "/" do
  @directories = DirectoriesController.instance.index
  erb :index
end

get "/user-folders/:user" do
  @directory = DirectoriesController.instance.show(params[:user])
  erb :show
end
