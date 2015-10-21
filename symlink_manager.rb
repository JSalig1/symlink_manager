require 'sinatra'
require 'dotenv'
require 'singleton'
require 'pathname'
require './lib/directory_helper'
require './lib/directories_controller'
require './lib/symlinks_controller'

Dotenv.load

get "/" do
  @directories = DirectoriesController.instance.index
  erb :index
end

get "/user-folders/:user" do
  @directory = DirectoriesController.instance.show(params[:user])
  @symlinks = SymlinksController.instance.index(@directory)
  erb :show
end
