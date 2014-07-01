rails_env = ENV['RAILS_ENV'] || 'development'
threads 1, 6
workers 1
preload_app!