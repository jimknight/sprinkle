package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libopenssl-ruby' do
    post :install, 'a2enmod rewrite'
    post :install, 'a2dissite default'
  end
  
end

package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end

package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  apt 'libcurl4-gnutls-dev'
  
 gem_version = '3.0.11'
  
  # load_file = '/etc/apache2/mods-available/passenger.load'
  # conf_file = '/etc/apache2/mods-available/passenger.conf'
  
  binaries = %w(passenger-config passenger-install-nginx-module passenger-install-apache2-module passenger-make-enterprisey passenger-memory-stats passenger-spawn-server passenger-status passenger-stress-test)

   gem 'passenger', :version => gem_version do
     binaries.each {|bin|}
  
  
  # gem 'passenger' do
    # cleanup any other versions of passenger we had installed
    # pre :install, 'gem uninstall passenger -a -x || true'
    # pre :install, 'rm -f /etc/apache2/mods-available/passenger.*'
    post :install, 'passenger-install-apache2-module --auto'
    # Create the passenger conf file
    # post :install, 'mkdir -p /etc/apache2/extras'
    # post :install, 'touch /etc/apache2/extras/passenger.conf'
    # post :install, 'echo "Include /etc/apache2/extras/passenger.conf"|sudo tee -a /etc/apache2/apache2.conf'
    # 
    # post :install, "echo \"LoadModule passenger_module `gem environment gemdir`/gems/passenger-#{gem_version}/ext/apache2/mod_passenger.so\" | sudo tee #{load_file}"
    #    post :install, "echo \"PassengerRoot `gem environment gemdir`/gems/passenger-#{gem_version}\" | sudo tee #{conf_file}"
    #    post :install, "echo \"PassengerRuby /usr/local/bin/ruby\" | sudo tee -a #{conf_file}"
    #    post :install, 'a2enmod passenger'
       
       # Create the passenger conf file
       post :install, 'mkdir -p /etc/apache2/extras'
       post :install, 'touch /etc/apache2/extras/passenger.conf'
       post :install, 'echo "Include /etc/apache2/extras/passenger.conf"|sudo tee -a /etc/apache2/apache2.conf'

       [%Q(LoadModule passenger_module /usr/local/lib/ruby/gems/1.9.1/gems/passenger-#{gem_version}/ext/apache2/mod_passenger.so),
       %Q(PassengerRoot /usr/local/lib/ruby/gems/1.9.1/gems/passenger-#{gem_version}),
       %q(PassengerRuby /usr/local/bin/ruby),
       %q(RailsEnv production)].each do |line|
         post :install, "echo '#{line}' |sudo tee -a /etc/apache2/extras/passenger.conf"
       end

       # Restart apache to note changes
       
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_file "/etc/apache2/mods-available/passenger.load"
    has_gem 'passenger'
    has_process 'apache2'
  end
  
  requires :apache
  requires :apache2_prefork_dev
end