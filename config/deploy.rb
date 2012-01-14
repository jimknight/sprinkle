require "bundler/capistrano"

set   :domain,        "69.172.229.224"
role  :web,           domain
role  :app,           domain
role  :db,            domain, :primary => true

# Fill user in - if remote user is different to your local user
set :user, "rails"

default_run_options[:pty] = true

set :application, "sprinkle"
set :scm, :git
set :repository,  "git://github.com/jimknight/sprinkle.git"
set :deploy_via, :copy
set :deploy_to, "/home/#{user}/#{application}"

# sudo -u postgres createdb sprinkle_production
before 'deploy:update_code' do
  run_locally "rake assets:precompile"
  run_locally "git add public/assets"
  run_locally "git commit -a -m 'automatic pre-deployment commit'"
  run_locally 'git push origin master'
end

require 'cap_recipes/tasks/thinking_sphinx'

# HACK: override ts symlink from cap-recipes, use -nfs
namespace :thinking_sphinx do
  desc "Copies the shared/config/sphinx yaml to release/config/"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml"
  end
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end