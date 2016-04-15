source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '>= 4.2.5'
gem 'mysql2', '>= 0.3.13', '< 0.5'
gem 'rest-client'

gem 'exception_notification'
gem 'slack-notifier'

group :production do
  gem 'pg'
  gem 'rails_12factor'

  gem 'uglifier', '>= 1.3.0'
  gem 'jquery-rails'
  gem 'sass-rails', '~> 5.0'
  gem 'turbolinks'
end

group :development, :test do
  gem 'sqlite3',     '1.3.9'
  gem 'byebug'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'binding_of_caller'
end

group :test do
  gem 'rspec-rails'
end
