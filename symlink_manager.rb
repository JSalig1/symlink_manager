require 'sinatra'
require 'dotenv'
require 'singleton'
require 'pathname'
require 'net/ssh'
require './lib/directory_helper'
require './lib/secure_shell'

Dotenv.load

get "/" do
  @directories = DirectoryHelper.instance.all
  erb :index
end

get "/user-folders/new" do
  erb :new
end

get "/user-folders/:user" do
  @directory = DirectoryHelper.instance.find_by(params[:user])
  @symlinks = DirectoryHelper.instance.find_symlinks_for(@directory)
  erb :show
end

get "/:user/new" do
  @user_folder = params[:user]
  @project_directories = DirectoryHelper.instance.find_all_project_directories
  erb :new_symlink
end

post '/user-folders' do
  DirectoryHelper.instance.new(params[:folder_name])
  redirect "/"
end

post '/:user/symlinks' do
  DirectoryHelper.instance.new_symlink(params[:user], params[:symlink_name])
  redirect "/"
end

delete '/:user/:symlink_name' do
  DirectoryHelper.instance.destroy_symlink(params[:user], params[:symlink_name])
  redirect "/"
end
