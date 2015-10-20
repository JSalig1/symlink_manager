class Directory
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    get_files_for(".")
  end

  private

  def self.get_files_for(path)
    Dir.entries(path).select(&only_directories).reject(&hidden_directories)
  end

  def self.only_directories
    Proc.new { |entry| File.directory? entry }
  end

  def self.hidden_directories
    Proc.new { |entry| entry.start_with?(".") }
  end
end
