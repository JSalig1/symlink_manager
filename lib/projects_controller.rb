class ProjectsController
  include Singleton

  def index
    DirectoryHelper.instance.find_all_project_directories
  end
end
