# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
    config.vm.provision "file", source: "sinatra_app", destination: "~/app"
    # config.vm.provision NOTE: Your provisioner here.
    # The script below does the following:
    # 1. Installs dependencies of the Sinatra application
    # 2. Runs the `rake db:migrate` rake task to create the guest_book_entries database table
    # 3. Starts the Sinatra application in a backgrounded Ruby process that will keep running
    script = <<-SHELL
      cd /home/vagrant/app
      if [ ! -f /home/vagrant/.rbenv/shims/bundle ]; then
	gem update --system
	gem install bundler
      fi
      if [ -f /home/vagrant/.rbenv/shims/bundle ]; then
        bundle install
      fi
      rake db:migrate
      sudo pkill -f ruby
      nohup ruby app.rb >> /var/log/sinatra_app/app.log 2>&1 &
    SHELL
    config.vm.provision "shell", inline: script, privileged: false, env: {
      'REALLY_GEM_UPDATE_SYSTEM': 'true',
      'SINATRA_ACTIVESUPPORT_WARNING': false,
      #'DB_USER': "some username here", # NOTE: The postgres username must be provided here via an environment variable
      #'DB_PASSWORD': "some password here", # NOTE: The postgres password must be provided here via an environment variable
    }
    config.vm.network "forwarded_port", guest: 4567, host: 4567 
end
