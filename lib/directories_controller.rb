class DirectoriesController
  include Singleton

  def index
    entries = Directory.all
    create_directories_from(entries)
  end

  def show(name)
    Directory.new(name)
  end

  private

  def create_directories_from(entries)
    entries.map! { |entry| Directory.new(entry) }
  end
end
