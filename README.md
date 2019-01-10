# Devops Candidate Project

This repo contains a [Vagrantfile](https://www.vagrantup.com/docs/index.html) and simple [Sinatra](http://sinatrarb.com/) application. The Sinatra app is a humble guestbook application for a BNB in Honolulu, Hawaii. The site displays the local time, the number of visits the site receives, and allows for guests to leave a guest book entry about their stay.

While you need not make any changes to the application, you must use the provided Vagrantfile to configure services to get the web application up and running. [You may use any of the provisioners supported by Vagrant to accomplish this](https://www.vagrantup.com/docs/provisioning/). 

When you’re done, we should be able to use the command `vagrant up` and see the following behavior after provisioning the VM.

- [ ] The web application loads successfully on the host system at localhost:4567.
- [ ] The correct system timezone is displayed.
- [ ] The web application manages logs as specified below.
- [ ] The web application increments visits to the root path, as expected.
- [ ] The web application allows for visitors to leave entries in the “guest book”, as expected.
- [ ] The web application must start again after either 1. the Ruby process is somehow stopped or 2. the VM is restarted.

The web application will be located at `/home/vagrant/app`.

The above will require you to implement the following configuration changes to the VM:

1. Change the system timezone to Pacific/Honolulu (GMT -10)
2. Install Redis
    * Redis should be installed and should be running on the default port
3. Ruby
    * Install Ruby 2.4.5 for the `vagrant` user
4. Logs
    * The web application will create a log file at `/var/log/sinatra_app/app.log`.
    * The log file must be rotated daily, with 10 logs kept in rotation.
    * The files must be compressed via gzip.
5. PostgreSQL
    * A client and server for PostgreSQL 10.6 should be installed and the service should be started
    * A database named `sinatra_app` should be created.
    * A user and password for the `sinatra_app` database should be provided by setting environment variables that will be available to the `vagrant` user. The environment variable `DB_USER` will set the database username and `DB_PASSWORD` will set the user’s password.
    * Use the default port of 5432
