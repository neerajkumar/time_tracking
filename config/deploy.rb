require 'rvm/capistrano'
set :application, "Time Tracker"
set :repository,  "git@github.com:neerajkumar/time_tracking.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
set :branch , "master"
set :user, "deploy"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :deploy_to, "/srv/time_tracker"
set :keep_releases, 3
set :domain, "104.131.110.105"
set :rvm_ruby_string, 'ruby-2.1.5'
set :rake, 'bundle exec rake'
set :default_shell, "/bin/bash -l"
set :rvm_type, :root
default_run_options[:pty] = true
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server domain, :app, :web, :db, :primary => true

role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

after "deploy:restart", "deploy:cleanup"
after "deploy:restart", "deploy:start_juggernaut"
before "deploy:restart", "deploy:tmp_symlinks"
before "deploy:restart", "deploy:create_symlink"
set :deploy_via, :remote_cache

after "deploy:update_code" do
  #run "ls -al #{fetch(:release_path)} && which ruby"
  bundle_dir = File.join(fetch(:shared_path), 'bundle')
  args = ["--path #{bundle_dir}"]
  args << "--without development"
  run "cd #{fetch(:release_path)} && bundle install #{args.join(' ')}"
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do

  #desc "Restarting httpd "
  #task :restart, :roles => :app, :except => { :no_release => true } do
  #  run "/sbin/service httpd stop"
  #  run "/sbin/service httpd start"
  #end

  task :create_symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    run "ln -nfs #{shared_path}/public/uploads #{current_path}/public"
    run "cd #{current_path}/public && rm -rf resources && ln -nfs #{shared_path}/public/resources #{current_path}/public"
    #run "cd #{current_path} && chmod -R 777 tmp/"
  end

  task :tmp_symlinks do
    run "cd #{current_path} && rm -rf tmp && ln -s #{shared_path}/tmp tmp"
  end

  desc "Recreate symlink"
  task :resymlink, :roles => :app do
    run "ln -nfs #{release_path} #{current_path}"
  end
end
before "deploy:create_symlink", "deploy:resymlink"

