source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'

gem 'pg', '>= 0.18', '< 2.0'

gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false

#Auth
gem 'devise_token_auth', '~> 1.1.4'

# CORS
gem 'rack-cors', '~> 1.1.1'

# Rendering
gem 'jbuilder', '~> 2.10.1'

#Rubocop
gem 'rubocop', require: false

#MailerCSS
gem 'inky-rb', require: 'inky'
gem 'premailer-rails'
gem 'foundation_emails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'shoulda-matchers', '~> 4.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
