set :application, 'travis'
set :repo_url, 'git@github.com:cinic/travis.git'


ask :branch, "master"
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/mongoid.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/upload}

set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :keep_releases, 3
set :use_sudo, false

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
    on roles :app do
      execute "cd #{current_path} && (RAILS_ENV=#{fetch(:stage)} ~/.rvm/bin/rvm default do rvmsudo bundle exec foreman export upstart /etc/init -a #{fetch(:app_name)} -u #{fetch(:user)} -l #{shared_path}/log/#{fetch(:app_name)})"
    end
  end

  desc "Start the application services"
  task :start do
    on roles :app do
      execute "sudo service #{fetch(:app_name)} start"
    end
  end

  desc "Stop the application services"
  task :stop do
    on roles :app do
      execute "sudo service #{fetch(:app_name)} stop"
    end
  end

  desc "Restart the application services"
  task :restart do 
    on roles :app do
      execute "sudo service #{fetch(:app_name)} start || sudo service #{fetch(:app_name)} restart"
    end
  end

end

namespace :deploy do
      # on OS X the equivalent pid-finding command is `ps | grep '/puma' | head -n 1 | awk {'print $1'}`
      #run "(kill -s SIGUSR1 $(ps -C ruby -F | grep '/puma' | awk {'print $2'})) || #{sudo} service #{fetch(:app_name)} restart"

  after :finishing, "deploy:cleanup"
  after :finishing, "foreman:export"
  after :finishing, "foreman:restart"
end
