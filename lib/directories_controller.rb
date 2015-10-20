class DirectoriesController
  include Singleton

  def index
    entries = get_files_for(".")
    create_directories_from(entries)
  end

  private

  def get_files_for(path)
    Dir.entries(path).select(&only_directories).reject(&hidden_directories)
  end

  def only_directories
    Proc.new { |entry| File.directory? entry }
  end

  def hidden_directories
    Proc.new { |entry| entry.start_with?(".") }
  end

  def create_directories_from(entries)
    entries.map! { |entry| Directory.new(entry) }
  end
end
