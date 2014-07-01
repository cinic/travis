source 'https://rubygems.org'

gem 'rails', '~>4.0.0'

gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
#gem 'slim_assets', '~> 0.0.2'
gem 'slim-rails'
gem 'jquery-rails'
gem 'modernizr-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
#gem 'nested_form'

gem 'mongoid', github: 'mongoid/mongoid'
#gem 'mongoid_slug'
gem 'bson'
gem 'bson_ext'
gem 'actionpack-action_caching'
gem 'actionpack-page_caching'
#gem 'devise', '>= 2.1.2'
#gem 'cancan'
gem 'nokogiri'
gem 'rack-rewrite'

gem 'puma'
gem 'foreman'

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'factory_girl_rails'
  #gem 'mongoid-rspec', '>= 1.6.0', github: 'evansagge/mongoid-rspec'
  gem 'email_spec'
  gem 'fuubar'
end

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm', github: 'capistrano/rvm'
end

group :test do
	gem 'faker'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'database_cleaner'
	gem 'launchy'
end