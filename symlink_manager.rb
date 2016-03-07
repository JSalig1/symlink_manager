require 'sinatra'
require 'dotenv'
require 'singleton'
require 'pathname'
require 'net/ssh'
require './lib/directory_helper'
require './lib/secure_shell'

Dotenv.load

get "/#{ENV['SUB_DIR']}/" do
  @directories = DirectoryHelper.instance.find_all_user_directories
  erb :index
end

get "/#{ENV['SUB_DIR']}/user-folders/new" do
  erb :new
end

get "/#{ENV['SUB_DIR']}/user-folders/:user" do
  @directory = DirectoryHelper.instance.find_user_directory_by(params[:user])
  @symlinks = DirectoryHelper.instance.find_symlinks_for(@directory)
  erb :show
end

get "/#{ENV['SUB_DIR']}/:user/new" do
  @user_folder = params[:user]
  @project_directories = DirectoryHelper.instance.find_all_project_directories
  erb :new_symlink
end

post "/#{ENV['SUB_DIR']}/user-folders" do
  DirectoryHelper.instance.create_new_user_directory(params[:folder_name])
  redirect "/#{ENV['SUB_DIR']}/"
end

post "/#{ENV['SUB_DIR']}/:user/symlinks" do
  DirectoryHelper.instance.create_new_symlink(params[:user], params[:symlink_name])
  redirect "/#{ENV['SUB_DIR']}/"
end

delete "/#{ENV['SUB_DIR']}/:user/:symlink_name" do
  DirectoryHelper.instance.destroy_symlink(params[:user], params[:symlink_name])
  redirect "/#{ENV['SUB_DIR']}/"
end
