# config valid for current version and patch releases of Capistrano
lock '3.12.0'

set :application, 'sample_app'
#アプリ名を記載
set :repo_url, 'github:ichihara-development-github/sample_app.git'
#cloneを行うリモートリポジトリを記載

set :rbenv_type, :user
set :rbenv_ruby, '2.6.5'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :log_level, :warn

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
# set :ssh_options, verify_host_key: :secure
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :keep_releases, 3

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

    end
  end
end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
