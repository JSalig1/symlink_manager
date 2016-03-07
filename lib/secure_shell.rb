class SecureShell
  def initialize(user, symlink_name)
    @target = symlink_name
    @user = user

    @session = Net::SSH.start(
      ENV['SERVER_HOST'],
      ENV['SERVER_USER'],
      password: ENV['SERVER_PASSWORD']
    )
  end


  def create_symlink
    command = generate_create
    @session.exec!(command)
    @session.close
  end

  def remove_symlink
    command = generate_remove
    @session.exec!(command)
    @session.close
  end

  private

  def generate_create
    "ln -s #{ENV['PATH_TO_PROJECT'] + @target} #{ENV['PATH_TO_USER'] + @user}/"
  end

  def generate_remove
    "rm #{ENV['PATH_TO_USER'] + @user}/" + @target
  end
end
