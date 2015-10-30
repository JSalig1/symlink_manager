class DirectoryHelper
  include Singleton

  def initialize
    @path = Pathname.new(ENV['SERVER_PATH'])
    @protected_directories = [ENV['PROJECT_TEMPLATE'], ENV['PROJECTS_DIRECTORY']]
  end

  def all
    @path.children.select(&only_directories).reject(&protected_directories)
  end

  def find_by(name)
    @path + name
  end

  def find_symlinks_for(directory)
    directory.children.select(&only_directories)
  end

  def find_all_project_directories
    project_directory = @path + "0_PROJECTS"
    project_directory.children.select(&only_directories)
  end

  def new(folder_name)
    Pathname.new(@path + folder_name).mkdir
  end

  def new_symlink(user, symlink_name)
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

  def protected_directories
    Proc.new { |path| @protected_directories.include? path.basename.to_s }
  end
end
