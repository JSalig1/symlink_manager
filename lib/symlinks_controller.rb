class SymlinksController
  include Singleton

  def index(directory)
    DirectoryHelper.instance.find_symlinks_for(directory)
  end

  def create(user, symlink_name)
    DirectoryHelper.instance.new_symlink(user, symlink_name)
  end

  def destroy(user, symlink_name)
    DirectoryHelper.instance.destroy_symlink(user, symlink_name)
  end
end
