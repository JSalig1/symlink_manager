class SymlinksController
  include Singleton

  def index(directory)
    DirectoryHelper.instance.find_symlinks_for(directory)
  end
end
