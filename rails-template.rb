gem 'slim'
gem 'simple_form', git: 'https://github.com/plataformatec/simple_form'

gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'quiet_assets'
  gem 'rack-mini-profiler'
  gem 'tapp'
  gem 'view_source_map'
  gem 'rspec-rails'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'terminal-notifier-guard'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

run "cat << EOF >> .gitignore
/.bundle
/log
/tmp
/.vagrant
*.swp
*~
.DS_Store
/db/*.sqlite3
/db/*.sqlite3-journal
EOF"

after_bundle do
  run 'bundle exec guard init rspec'
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
