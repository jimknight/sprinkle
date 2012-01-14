require "bundler/capistrano"
# Fill slice_url in - where you're installing your stack to
role :app, "69.172.229.224"

# Fill user in - if remote user is different to your local user
set :user, "rails"

default_run_options[:pty] = true

set :application, "sprinkle"
set :repository,  "git://github.com/jimknight/sprinkle.git"
set :deploy_via, :copy

set :user, 'rails' # Your username goes here
set :use_sudo, false
# set :domain, 'tweetni.com' # Your domain goes here
set :deploy_to, "/home/#{user}/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "apache"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end