source 'https://rubygems.org'

gem 'rails', '5.1.1'
gem 'rack-cache', '1.5.1'

### Standard Gem Package #####


# Dev/Test gems
group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails'
	gem "capybara"
	gem 'annotate'
	gem "factory_girl_rails"
  gem "guard-rspec"
  gem "growl"
  gem "rb-fsevent", :require => false
  gem "faker"
	gem "spring"
end

group :production do

end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '5.0.6'
  gem 'coffee-rails', '4.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby
	gem 'execjs', '2.7.0'

  gem 'uglifier', '3.0.2'
end

# webserver
gem "unicorn", "5.3.0"

# new mysql2 gem
gem 'mysql2', "0.4.4"

gem 'jquery-rails', '4.2.1'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.1.5'

# REST client + JSON for easy sorting
gem 'rest-client', '1.8.0'   ## do not change this, 2.0 is fucked on multipart headers.
gem 'json', '2.1.0'

# Mongo support
gem "bson", "4.1.1"
gem "mongo", "2.2.7"
### End Standard Gem Package #####
