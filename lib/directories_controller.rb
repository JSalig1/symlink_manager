class DirectoriesController
  include Singleton

  def index
    DirectoryHelper.instance.all
  end

  def show(name)
    DirectoryHelper.instance.find_by(name)
  end
end
