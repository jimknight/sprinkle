package :rails do
  description 'Ruby on Rails'
  gem 'rails'
  gem 'bundler'
  
  verify do
    has_gem 'rails'
    has_gem 'bundler'
  end
end