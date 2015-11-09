class DirectoryHelper
  include Singleton

  def initialize
    @path = Pathname.new(ENV['SERVER_PATH'])
    @project_directories = [ENV['PROJECT_TEMPLATE'], ENV['PROJECTS_DIRECTORY']]
  end

  def find_all_user_directories
    @path.children.select(&only_directories).reject(&project_directories)
  end

  def find_user_directory_by(user)
    @path + user
  end

  def find_symlinks_for(directory)
    directory.children.select(&only_directories)
  end

  def find_all_project_directories
    project_directory = @path + "0_PROJECTS"
    project_directory.children.select(&only_directories)
  end

  def create_new_user_directory(folder_name)
    Pathname.new(@path + folder_name).mkdir
  end

  def create_new_symlink(user, symlink_name)
    if @path.to_s == ENV['SERVER_PATH']
      secure_shell = SecureShell.new(user, symlink_name)
      secure_shell.create_symlink
    end
  end

  def destroy_symlink(user, symlink_name)
    if @path.to_s == ENV['SERVER_PATH']
      secure_shell = SecureShell.new(user, symlink_name)
      secure_shell.remove_symlink
    end
  end

  private

  def only_directories
    Proc.new { |path| path.directory? }
  end

  def project_directories
    Proc.new { |path| @project_directories.include? path.basename.to_s }
  end
end
