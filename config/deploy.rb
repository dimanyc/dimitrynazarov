# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'dimitrynazarov'
set :repo_url, 'https://github.com/dimanyc/dimitrynazarov.git'

set :deploy_to, '/home/deploy/dimitrynazarov'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end