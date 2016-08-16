gem 'config'

gem_group :development, :test do
  gem 'factory_girl_rails'
  gem 'forgery'
end

gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'rack-mini-profiler', require: false
  gem 'rubocop', require: false
  gem 'tapp'
  gem 'view_source_map'
  gem 'rspec-rails'
  gem 'rspec-request_describer'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-rubocop'
  gem 'terminal-notifier-guard'
  gem 'fuubar'
  gem 'spring-commands-rspec'
  gem 'annotate'
  gem 'parallel_tests'
  gem 'rails-erd'
end

gem_group :test do
  gem 'database_cleaner'
  gem 'autodoc'
  gem 'webmock'
  gem 'timecop'
end

file '.rubocop.yml', <<-CODE
Rails:
  Enabled: true

AllCops:
  TargetRubyVersion: 2.3
  Exclude:
    - "vendor/bundle/**/*"
    - ",/**/*"
    - ".git/**/*"
    - "bin/*"
    - "db/schema.rb"
    - "db/migrate/*.rb"
    - "log/**/*"
    - "public/**/*"
    - "tmp/**/*"
    - "config/initializers/*"
    - "*file"

Metrics/LineLength:
  Max: 120
  Exclude:
    - "app/views/**/*"
    - "config/**/*.rb"
    - "spec/factories/**/*.rb"
    - "Guardfile"

Documentation:
  Enabled: false

Style/TrailingCommaInLiteral:
  EnforcedStyleForMultiline: comma

Style/TrailingCommaInArguments:
  EnforcedStyleForMultiline: comma

Style/AsciiComments:
  Enabled: false

Style/ClassAndModuleChildren:
  Enabled: false

Style/RegexpLiteral:
  Enabled: true
CODE

file 'spec/support/factory_girl.rb', <<-CODE
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
CODE

file 'spec/support/database_cleaner.rb', <<-CODE
require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
CODE

file 'spec/support/timecop.rb', <<-CODE
RSpec.configure do |config|
  config.after(:each) do
    Timecop.return
  end
end
CODE

run 'curl -L https://raw.githubusercontent.com/github/gitignore/master/Rails.gitignore > ./.gitignore'
run 'rm README.rdoc'

git :init
git add: '.'
git commit: "-a -m 'Initial commit'"

run 'bundle install'

run 'bin/rails g rspec:install'
file '.rspec', <<-CODE
--color
--require spec_helper
--format Fuubar
CODE
git add: '.'
git commit: "-a -m 'rspec:install'"

run 'bundle exec guard init'
git add: '.'
git commit: "-a -m 'guard init'"

run 'bundle exec spring binstub --all'
git add: '.'
git commit: "-a -m 'spring binstub --all'"

rails_command 'db:create'
