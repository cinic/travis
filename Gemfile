source 'https://rubygems.org'

gem 'rails', '3.2.12'

group :assets do
	gem 'sass-rails',   '~> 3.2.3'
	gem 'coffee-rails', '~> 3.2.1'
	gem 'slim_assets', '~> 0.0.2'
	gem 'jquery-rails'
	gem 'modernizr-rails'

	# See https://github.com/sstephenson/execjs#readme for more supported runtimes
	# gem 'therubyracer', :platforms => :ruby

	gem 'uglifier', '>= 1.0.3'
	#gem 'nested_form'
end

gem 'mongoid', '>= 3.0.3'
#gem 'mongoid_slug'
gem 'slim-rails', '~> 1.1.0'
#gem 'bson_ext'
#gem 'devise', '>= 2.1.2'
#gem 'cancan'
gem 'nokogiri'
gem 'rack-rewrite'

group :development, :test do
	gem 'rspec-rails'
	gem 'cucumber-rails', :require => false
end

group :test do
	gem 'capybara'
	gem 'mongoid-rspec'
	gem 'database_cleaner'
	gem 'email_spec'
	gem 'factory_girl_rails'
	gem 'launchy'
end