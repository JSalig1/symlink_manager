require 'net/ssh'

class SecureShell
  def initialize(user, project_directory)
    @target = project_directory
    @user = user
    create_symlink
  end

  private

  def create_symlink
    Net::SSH.start(ENV['SERVER_HOST'], ENV['SERVER_USER'], password: ENV['SERVER_PASSWORD']) do |ssh|
      command = generate_command_string
      output = ssh.exec!(command)
      puts output
    end
  end

  def generate_command_string
    "ln -s #{ENV['PATH_TO_PROJECT'] + @target} #{ENV['PATH_TO_USER'] + @user}/"
  end
end
