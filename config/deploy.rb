require "bundler/capistrano"
# Fill slice_url in - where you're installing your stack to
role :app, "69.172.229.224"

# Fill user in - if remote user is different to your local user
set :user, "rails"

default_run_options[:pty] = true

set :application, "sprinkle"
set :scm, :git
set :repository,  "git://github.com/jimknight/sprinkle.git"
set :deploy_via, :copy
set :deploy_to, "/home/#{user}/#{application}"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end