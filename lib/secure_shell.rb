class SecureShell
  def initialize(user, symlink_name)
    @target = symlink_name
    @user = user

    Net::SSH::Transport::Algorithms::ALGORITHMS[:encryption] = %w(
      aes128-cbc 3des-cbc blowfish-cbc cast128-cbc
      aes192-cbc aes256-cbc arcfour128 arcfour256 arcfour
      aes128-ctr aes192-ctr aes256-ctr cast128-ctr blowfish-ctr 3des-ctr
    )

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
