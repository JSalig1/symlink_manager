class DirectoryHelper
  include Singleton

  def initialize
    @path = Pathname.new(ENV['LOCAL_PATH'])
    @protected_directories = ENV['PROTECTED_DIRECTORIES']
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

  def new(folder_name)
    Pathname.new(@path + folder_name).mkdir
  end

  private

  def only_directories
    Proc.new { |path| path.directory? }
  end

  def protected_directories
    Proc.new { |path| @protected_directories.include? path.basename.to_s }
  end
end
