class DirectoryHelper
  include Singleton

  def initialize
    @path = Pathname.new(ENV['SERVER_PATH'])
  end

  def all
    @path.children.select(&only_directories)
  end

  def find_by(name)
    @path + name
  end

  private

  def only_directories
    Proc.new { |path| path.directory? }
  end
end
