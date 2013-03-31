require "bundler/capistrano"
 
# Application Settings
set :application, "discoursebp"
set :deploy_to, "/u/apps/#{application}"
 
# Repo Settings
# Cloned to a private copy of discourse
# set :repository, "ssh://git@github.com/xxxxxxxx/discourse.git"
# set :deploy_via, :remote_cache
# set :branch, fetch(:branch, "master")
set :scm, :git
set :deploy_via, :copy
set :scm_verbose, true
ssh_options[:forward_agent] = true
 
# General Settings
set :use_sudo, false
set :deploy_type, :deploy
default_run_options[:pty] = true
 
# Server Settings
set :user, "borderprinces"
set :rails_env, :production
 
role :app, "forum.wfb-pol.org"
role :db, "forum.wfb-pol.org"
role :web, "forum.wfb-pol.org", :primary => true
 
# Hooks
after "deploy:setup" do
  run "cd #{current_path} && bundle install"
end
 
# Seed the database
 
 
 
# Bluepill related tasks
after "deploy:update", "bluepill:quit", "bluepill:start"
 
namespace :bluepill do
  desc "Stop processes that bluepill is monitoring and quit bluepill"
  task :quit, :roles => [:app] do
    sudo "bluepill stop"
    sudo "bluepill quit"
  end
 
  desc "Load bluepill configuration and start it"
  task :start, :roles => [:app] do
    sudo "bluepill load /u/apps/#{application}/current/config/discourse.pill"
  end
 
  desc "Prints bluepills monitored processes statuses"
  task :status, :roles => [:app] do
    sudo "bluepill status"
  end
 
  desc "Stops bluepill from running services"
  task :stop, :roles => [:app] do
    sudo "bluepill stop"
  end
end
 
namespace :db do 
  desc "seed the database for the first time"
  task :seed, :roles => [:db] do
    sudo "cd #{current_path} && bundle exec rake db:migrate"
    sudo "cd #{current_path} && bundle exec rake db:seed_fu"
  end
end