namespace :load do
  task :defaults do
    set :clockwork_default_hooks, -> { true } 
    set :clockwork_file, -> { "lib/clockwork.rb" }
  end
end

namespace :deploy do
  before :starting, :check_sidekiq_hooks do
    invoke 'clockwork:add_default_hooks' if fetch(:clockwork_default_hooks)
  end
  after :publishing, :restart_sidekiq do
    invoke 'clockwork:restart' if fetch(:clockwork_default_hooks)
  end
end

namespace :clockwork do
  desc "Stop clockwork"
  task :stop do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c #{fetch(:clockwork_file)} --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} --log stop"
        end
      end
    end
  end

  desc "Clockwork status"
  task :status do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c #{fetch(:clockwork_file)} --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} --log status"
        end
      end
    end
  end

  desc "Start clockwork"
  task :start do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c #{fetch(:clockwork_file)} --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} --log start"
        end
      end
    end
  end

  desc "Restart clockwork"
  task :restart do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c #{fetch(:clockwork_file)} --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} --log restart"
        end
      end
    end
  end

  def cw_log_dir
    "#{shared_path}/log"
  end
  def cw_pid_dir
    "#{shared_path}/tmp/pids"
  end

  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end

  task :add_default_hooks do
    after 'deploy:stop', 'clockwork:stop'
    after 'deploy:start', 'clockwork:start'
    after 'deploy:restart', 'clockwork:restart'
  end
end